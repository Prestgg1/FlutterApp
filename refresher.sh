cd ~/test
rm -rf flutter_api_client
rm -rf openapi.json
wget --no-check-certificate https://bimonet.com/openapi.json
java -jar openapi-generator-cli.jar generate \
      -i openapi.json \
      -g dart-dio \
      -o flutter_api_client
cd flutter_api_client
dart run build_runner build --delete-conflicting-outputs
cd ~/test/sefatapp2
flutter pub get