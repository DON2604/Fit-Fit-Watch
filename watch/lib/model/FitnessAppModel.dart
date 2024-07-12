import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';




class FitnessAppModel extends ChangeNotifier {
  final String rpcUrl = "http://192.168.1.182:7545";
  final String wsUrl = "ws://192.168.1.182:7545/";

  final String? privateKey =
      "0x519a1d2e87ee858fad5f8d023a9e39e1015d685a1c851cc9fbf39b4fd9025c76";

  Credentials? credentials;
  Web3Client? client;
  String? abiCode;
  EthereumAddress? contractAddress;
  EthereumAddress? ownAddress;
  DeployedContract? contract;

  ContractFunction? updateUserData;
  ContractFunction? earnCoins;
  ContractFunction? setItemPrice;
  ContractFunction? buyItem;
  ContractFunction? getBalance;
  ContractFunction? getItemPrice;
  ContractEvent? CoinsEarned;
  ContractEvent? ItemBought;


  FitnessAppModel() {
    initialSetup();
  }

  Future<void> initialSetup() async {
    client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getCredentials() async {
    if (client != null && privateKey != null) {
      credentials = await client!.credentialsFromPrivateKey(privateKey!);
      ownAddress = await credentials!.extractAddress();
      print("Own Address: $ownAddress");
    }
  }

  Future<BigInt> getDeployedContract() async {
    String abiStringFile =
        await rootBundle.loadString("build/contracts/FitnessApp.json");
    var abiJson = jsonDecode(abiStringFile);
    abiCode = jsonEncode(abiJson["abi"]);
    contractAddress =
        EthereumAddress.fromHex(abiJson["networks"]["5777"]["address"]);
    print(abiCode);

    if (abiCode == null || contractAddress == null) {
      print("Error: ABI or contract address not loaded properly.");
    }
    contract = DeployedContract(
        ContractAbi.fromJson(abiCode!, "FitnessApp"), contractAddress!);

    updateUserData = contract!.function("updateUserData");
    earnCoins = contract!.function("earnCoins");
    setItemPrice = contract!.function("setItemPrice");
    buyItem = contract!.function("buyItem");
    getBalance = contract!.function("getBalance");
    getItemPrice = contract!.function("getItemPrice");
    CoinsEarned = contract!.event("CoinsEarned");
    ItemBought = contract!.event("ItemBought");

    print("Contract Initialized: $contract");
    print("getBalance Function: $getBalance");
    final bal = getBal();
    return bal;
  }

  Future<BigInt> getBal() async {
    if (client != null && contract != null && getBalance != null) {
      final result = await client!
          .call(contract: contract!, function: getBalance!, params: []);
      print("Balance result: $result");
      return result.first as BigInt;
    }
    print("Contract: $contract");
    print("Get Balance Function: $getBalance");
    print("Client: $client");
    return BigInt.two;
  }

  Future<void> earnCoin(int steps, int distance) async {
    if (client != null &&
        contract != null &&
        earnCoins != null &&
        updateUserData != null) {
      await client!.sendTransaction(
        credentials!,
        Transaction.callContract(
          contract: contract!,
          function: updateUserData!,
          parameters: [BigInt.from(steps), BigInt.from(distance)],
        ),
      );

      await client!.sendTransaction(
        credentials!,
        Transaction.callContract(
          contract: contract!,
          function: earnCoins!,
          parameters: [],
        ),
      );

      notifyListeners();
    }
  }

  Future<void> buiItem(String itemName) async {
    if (client != null && contract != null && buyItem != null) {
      final price = await client!.call(
          contract: contract!, function: getItemPrice!, params: [itemName]);
      print("Item price: $price");

      await client!.sendTransaction(
        credentials!,
        Transaction.callContract(
          contract: contract!,
          function: buyItem!,
          parameters: [itemName],
          gasPrice: EtherAmount.inWei(BigInt.from(20000000000)),
          maxGas: 300000,
        ),
      );

      notifyListeners();
    }
  }
}
