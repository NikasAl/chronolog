import com.android.build.gradle.LibraryExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Fix for plugins without namespace (isar_flutter_libs, etc.)
// Must be configured BEFORE project evaluation
subprojects {
    // Skip the app module
    if (project.name != "app") {
        project.plugins.whenPluginAdded { plugin ->
            if (plugin is com.android.build.gradle.LibraryPlugin) {
                project.extensions.configure<LibraryExtension>("android") {
                    if (namespace == null) {
                        namespace = "com.example.chronolog.${project.name}"
                    }
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
