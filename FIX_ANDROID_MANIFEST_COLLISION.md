# TTNDATVIMS DocOpen duplicate AndroidManifest fix

This archive is a **build-toolkit patch**, not a finished APK. It is based on the previous 15.55.55 / AIR 51.4.1.2 / Android target SDK 35 / ARM64 DocOpen-only toolkit.

## Error fixed
Gradle packageRelease: `app-release.apk already contains entry 'AndroidManifest.xml', cannot overwrite`.
The prior `DocOpen.ane` carried a legacy Android Eclipse *project archive* inside its `docext.jar`, including an unwanted **root `AndroidManifest.xml`**. Gradle then attempted to package that alongside the actual application manifest. This ZIP contains a re-packed DocOpen extension with **compiled Java classes only**, plus the existing `META-INF/MANIFEST.MF` in the Java JAR. Neither ARM nor ARM64 JAR contains an extra AndroidManifest.xml, Android res/ tree, .project/.classpath, or embedded support-v4 JAR.

## Apply

1. Extract the `RELEASE_DOCOPEN_ARM64` folder into `C:\FXWS47\TTNDATVIMS\` (replace previous toolkit files). In particular replace `RELEASE_DOCOPEN_ARM64\extensions\DocOpen.ane`.
2. **Keep** your original signing certificate at `C:\TTNDATVIMS_KEYS\inspectfhn.p12` and supply its password only when prompted locally. It is not included here.
3. Run `COMPILE_RELEASE_SWF.cmd` (if needed), then `BUILD_RELEASE_APK.cmd`.
4. Expected file: `RELEASE_DOCOPEN_ARM64\output\TTNDATVIMS-15.55.55-arm64-docopen-release.apk` if ADT completes successfully.

## Verifications and limitations

- The ANE still declares extension ID `com.naib.docopen` and includes `Android-ARM64/docext.jar` and `Android-ARM64/library.swf`.
- Original Java bytecode `.class` entries are retained byte-for-byte; this package does **not** update the document-opening code.
- The original document-opening method uses `Uri.fromFile(...)`. On modern Android with target 35, this can fail with `FileUriExposedException`. A code fix with a modern content URI/FileProvider or equivalent is still needed before production deployment.
- A legacy Activity class references generated R layout resources; those resources were previously incorrectly embedded in the Java JAR. If that activity is actually used, it must be modernized and resources integrated properly. The FRE document-opening method itself does not instantiate the activity.
- The existing application may require additional file-access permissions or different document access techniques on Android 15/17. Test the document-opening function on your Galaxy Tab S10 FE+.
- A build failure mentioning SDK XML v4 is a separate tooling mismatch; it is not directly related to this manifest collision. If a new failure appears, keep the exact build log.
- A successful build does NOT guarantee all DocOpen functions work. This is a release candidate until device testing is complete.
