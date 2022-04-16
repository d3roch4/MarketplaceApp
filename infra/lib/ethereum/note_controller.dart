import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class NoteController extends ChangeNotifier {
  List<dynamic> notes = [];
  bool isLoading = true;
  int noteCount = 0;
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";

  final String _privateKey =
      "416fde10fda9e26a698e42ad61568d13b7a3cef563b7df234c655e3d98f08359";

  Web3Client? _client;
  String? _abiCode;

  Credentials? _credentials;
  EthereumAddress? _contractAddress;
  DeployedContract? _contract;

  ContractFunction? _notesCount;
  ContractFunction? _notes;
  ContractFunction? _addNote;
  ContractFunction? _deleteNote;
  ContractFunction? _editNote;
  ContractEvent? _noteAddedEvent;
  ContractEvent? _noteDeletedEvent;
  ContractFunction? _deleteeNote;

   NoteController() {
    init();
  }

  init() async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCreadentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle
        .loadString("contracts/build/contracts/NotesContract.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCreadentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode!, "NotesContract"), _contractAddress!);
    _notesCount = _contract?.function("notesCount");
    _notes = _contract?.function("notes");
    _addNote = _contract?.function("addNote");
    _deleteeNote = _contract?.function("deleteNote");
    _editNote = _contract?.function("editNote");

    _noteAddedEvent = _contract?.event("NoteAdded");
    _noteDeletedEvent = _contract?.event("NoteDeleted");
    await getNotes();
  }

    getNotes() async {
    List notesList = await _client
        .call(contract: _contract, function: _notesCount, params: []);
    BigInt totalNotes = notesList[0];
    noteCount = totalNotes.toInt();
    notes.clear();
    for (int i = 0; i < noteCount; i++) {
      var temp = await _client.call(
          contract: _contract, function: _notes, params: [BigInt.from(i)]);
      if (temp[1] != "")
        notes.add(
          Note(
            id: temp[0].toString(),
            title: temp[1],
            body: temp[2],
            created:
                DateTime.fromMillisecondsSinceEpoch(temp[3].toInt() * 1000),
          ),
        );
    }
    isLoading = false;
    notifyListeners();
  }

  addNote(Note note) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _addNote,
        parameters: [
          note.title,
          note.body,
          BigInt.from(note.created.millisecondsSinceEpoch),
        ],
      ),
    );
    await getNotes();
  }

  deleteNote(int id) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _deleteeNote,
        parameters: [BigInt.from(id)],
      ),
    );
    await getNotes();
  }

  editNote(Note note) async {
    isLoading = true;
    notifyListeners();
    print(BigInt.from(int.parse(note.id)));
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _editNote,
        parameters: [BigInt.from(int.parse(note.id)), note.title, note.body],
      ),
    );
    await getNotes();
  }

}
