pragma solidity ^0.5.0;

contract DStorage {

  string public name = 'DStorage';
  uint public fileCount = 0;                    // Number of files
  mapping (uint => File) public files;          // Mapping fileId=>Struct
  struct File{                                  // Struct
    uint fileId;
    string fileHash;
    uint fileSize;
    string fileType;
    string fileName;
    string fileDescription;
    uint uploadTime;
    address payable uploader;
  }
 
    // Event
   event FileUploaded(                       
    uint fileId,
    string fileHash,
    uint fileSize,
    string fileType,
    string fileName, 
    string fileDescription,
    uint uploadTime,
    address payable uploader
  );
  

  constructor() public {
  }

  function uploadFile(string memory _fileHash,       // Upload File function
                      uint _fileSize,
                      string memory _fileType, 
                      string memory _fileName, 
                      string memory _fileDescription) public {

    require(bytes(_fileHash).length > 0);            // Make sure the file hash exists
    require(bytes(_fileType).length > 0);            // Make sure file type exists
    require(bytes(_fileDescription).length > 0);     // Make sure file description exists
    require(bytes(_fileName).length > 0);            // Make sure file fileName exists
    require(msg.sender!=address(0));                 // Make sure uploader address exists
    require(_fileSize>0);                            // Make sure file size is more than 0

    fileCount  = fileCount +1;                       // Increment file id

    files[fileCount] = File(fileCount,
                            _fileHash,               // Add File to the contract
                            _fileSize, 
                            _fileType, 
                            _fileName,
                            _fileDescription, 
                              now , msg.sender);

    // Trigger an event
    emit FileUploaded(fileCount, 
                      _fileHash, 
                      _fileSize, 
                      _fileType, 
                      _fileName, 
                      _fileDescription, 
                        now, msg.sender);

  }

}