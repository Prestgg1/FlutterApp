cd ..
rm -rf flutter_api_client
rm -rf openapi.json
wget --no-check-certificate https://bimonet.com/openapi.json
openapi-generator-cli generate \
      -i openapi.json \
      -g dart-dio \
      -o flutter_api_client
cd flutter_api_client
dart run build_runner build --delete-conflicting-outputs
cd FlutterApp
flutter pub get