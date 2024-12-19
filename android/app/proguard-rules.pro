-keep class okhttp3.** { *; }
-keep class com.squareup.moshi.** { *; }  
-keep class retrofit2.** { *; }           
-keepattributes Signature
-keepattributes *Annotation*
-keepclassmembers class ** {
    @com.google.gson.annotations.SerializedName <fields>;
}
# Obfuscate all classes and methods
-keep public class * {
    public *;
}

# Protect against reflection-based attacks
-keepattributes *Annotation*

# Keep Gson serialized fields
-keep class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Obfuscate resources
-dontpreverify
-renamesourcefileattribute SourceFile
-keepattributes LineNumberTable
