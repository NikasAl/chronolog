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

// Fix for isar_flutter_libs compatibility with AGP 8.x
// Removes package attribute from AndroidManifest.xml
subprojects {
    tasks.configureEach {
        if (name == "processDebugManifest" || name == "processReleaseManifest") {
            doFirst {
                val manifestFile = file("${project.projectDir}/src/main/AndroidManifest.xml")
                if (manifestFile.exists()) {
                    val content = manifestFile.readText()
                    if (content.contains("package=\"dev.isar.isar_flutter_libs\"")) {
                        val newContent = content.replace(
                            Regex("""package="dev\.isar\.isar_flutter_libs"[[:space:]]*"""),
                            ""
                        )
                        manifestFile.writeText(newContent)
                        println("Fixed AndroidManifest.xml for isar_flutter_libs: removed package attribute")
                    }
                }
            }
        }
    }
    
    // Also set namespace
    pluginManager.withPlugin("com.android.library") {
        extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
            if (namespace == null) {
                namespace = "dev.isar.isar_flutter_libs"
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
