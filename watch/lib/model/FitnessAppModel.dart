// ignore_for_file: unused_field, unused_import, file_names, non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class FitnessAppModel extends ChangeNotifier {
  final String _rpcUrl = "http://192.168.0.5:7545";
  final String _wsUrl = "ws://192.168.0.5:7545/";

  final String? _privateKey = "0x4be807680cb344dd67e73d392b963e670d6cec340bd9d2ba3366969fb7c888a8";

  Credentials? _credentials;
  Web3Client? _client;
  String? _abiCode;
  EthereumAddress? _contractAddress;
  EthereumAddress? _ownAddress;
  DeployedContract? _contract;
  
  ContractFunction? _updateUserData;
  ContractFunction? _earnCoins;
  ContractFunction? _setItemPrice;
  ContractFunction? _buyItem;
  ContractFunction? _getBalance;
  ContractFunction? _getItemPrice;
  ContractEvent? _CoinsEarned;
  ContractEvent? _ItemBought;
  
  FitnessAppModel() {
    initialSetup();
  }

  initialSetup() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/abis/FitnessApp.json");
    var abiJson = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(abiJson["abi"]);
    _contractAddress = EthereumAddress.fromHex(abiJson["address"]["networks"]["5777"]["address"]);
    
    
  }

  Future<void> getCredentials() async {
    if (_client != null && _privateKey != null) {
      _credentials = await _client!.credentialsFromPrivateKey(_privateKey);
      _ownAddress = await _credentials!.extractAddress();
    }
  }
  Future<void> getDeployedContract() async{
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode!, "FitnessApp"), _contractAddress!);
    
    _updateUserData = _contract!.function("updateUserData");
    _earnCoins = _contract!.function("earnCoins");
    _setItemPrice = _contract!.function("setItemPrice");
    _buyItem = _contract!.function("buyItem");
    _getBalance = _contract!.function("getBalance");
    _getItemPrice = _contract!.function("getItemPrice");
    _CoinsEarned = _contract!.event("CoinsEarned");
    _ItemBought = _contract!.event("ItemBought");
    
  }
}

class Coins {
  final int balance;
  final int steps;
  final int distance;

  Coins({
    this.balance = 0,
    this.steps = 0,
    this.distance = 0,
  });
}
