#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <Web3.h>

// WiFi credentials
const char* ssid = "YourWiFiSSID";
const char* password = "YourWiFiPassword";

// Ethereum node settings
const char* ethNode = "YourEthereumNodeURL";
const char* privateKey = "YourPrivateKey";

Web3 web3(ethNode);

void setup() {
  Serial.begin(115200);
  delay(10);

  // Connect to WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Connecting to WiFi...");
  }

  Serial.println("Connected to WiFi!");

  // Initialize Web3
  web3.setProvider(ethNode);
  web3.personal.setPrivateKey(privateKey);
}

void loop() {
  // Your main code logic here
}
