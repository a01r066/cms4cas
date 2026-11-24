import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.cmskiss.cms_kiss.dev"
            resValue(type = "string", name = "app_name", value = "CMS Dev")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.cmskiss.cms_kiss"
            resValue(type = "string", name = "app_name", value = "CMS")
        }
    }
}
