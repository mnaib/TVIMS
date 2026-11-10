TTNDATVIMS - DocOpen Android API 35 provider build-guard fix

Why the build stopped:
The old build script rejected android:exported anywhere in the descriptor.
The new DocOpen ContentProvider correctly needs android:exported="false".
This is NOT an AIR activity override.

How to apply:
1. Backup C:\FXWS47\TTNDATVIMS\RELEASE_DOCOPEN_ARM64\BUILD_RELEASE_APK.ps1
2. Extract this ZIP into C:\FXWS47\TTNDATVIMS\ and overwrite ONLY BUILD_RELEASE_APK.ps1
3. Do NOT overwrite or edit your current TTNDATVIMS-RELEASE-app.xml or DocOpen.ane
4. Run C:\FXWS47\TTNDATVIMS\RELEASE_DOCOPEN_ARM64\BUILD_RELEASE_APK.cmd
5. Enter original P12 password locally

This patch does not change AIR 51.4.1.2, Android target 35, app version 15.55.55,
app signing, extension binaries, or storage permissions.

Changed line:
OLD: if ($manifest -match 'android:exported') { throw 'Do not override AIR main activity android:exported.' }
NEW: if ($manifest -match '(?is)<activity\b[^>]*\bandroid:exported\s*=') { throw 'Do not override AIR main activity android:exported.' }

Result: provider android:exported="false" is allowed, while activity overrides
are still blocked.  This fixes only the false-positive script check; Android
manifest validation and runtime behavior still need to pass.
