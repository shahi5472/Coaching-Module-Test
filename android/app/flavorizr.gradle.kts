import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.shahi.coaching_module"
            resValue(type = "string", name = "app_name", value = "Coaching Module")
        }
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.shahi.coaching_module.dev"
            resValue(type = "string", name = "app_name", value = "[Dev] Coaching Module")
        }
    }
}