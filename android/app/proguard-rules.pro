# Preserve errorprone annotations
-keep class com.google.errorprone.annotations.** { *; }
-dontwarn com.google.errorprone.annotations.**

# Preserve javax.annotation classes
-keep class javax.annotation.** { *; }
-dontwarn javax.annotation.**

# Preserve concurrency annotations
-keep class javax.annotation.concurrent.** { *; }
-dontwarn javax.annotation.concurrent.**
