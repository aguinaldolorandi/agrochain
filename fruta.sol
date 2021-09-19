/ SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

contract Fruta {
    address owner;
    uint256 private id;
    
    struct Farm {
        address farm;
        //string fruta;
        uint256 volume;
        uint256 date; //data da safra - Ex. 1 Jun 2021 00:00:00 GMT - timestamp = 1622505600
        string local;
        bool organico;
        string ipfs_data;
        uint256 id;
        
    }
    
    mapping(address => mapping(uint256 => Farm[])) product; // address do produtor com os respectivos id's dos produtos e um array de struct com os trace dos players
    mapping(address => uint256[]) idProduct; // address do produtor e os id's dos produtos

    
    constructor (){
        owner = msg.sender;
    }
    
    function addProduct(address farm, uint256 volume, string memory local, bool organico, string  memory ipfs_data_producer ) public {
        require(msg.sender == farm);
        id ++;
        uint256 date = block.timestamp;
        product[farm][id].push(Farm(farm,volume,date,local,organico,ipfs_data_producer, id));
        idProduct[farm].push(id);
    }
    
    function addProcess(address farm, uint256 _id,address industry, uint256 volume, string memory local, string  memory ipfs_data_process) public {
        _id = id;
        require(msg.sender == industry);
        require(product[farm][_id][0].id >=1);
        uint256 date = block.timestamp;
        bool _organico = product[farm][id][0].organico;
        product[farm][id].push(Farm(industry,volume,date,local,_organico,ipfs_data_process, _id));
    }
    
    function addWholesale(address farm, uint256 _id,address wholesale, uint256 volume, string memory local, string  memory ipfs_data_wholesale) public {
        _id = id;
        require(msg.sender == wholesale);
        require(product[farm][_id][1].id >=1);
        uint256 date = block.timestamp;
        bool _organico = product[farm][id][0].organico;
        product[farm][id].push(Farm(wholesale,volume,date,local,_organico,ipfs_data_wholesale, _id));
    }
    
    function addRetailer(address farm, uint256 _id,address retailer, uint256 volume, string memory local, string  memory ipfs_data_retailer) public {
        _id = id;
        require(msg.sender == retailer);
        require(product[farm][_id][2].id >=1);
        uint256 date = block.timestamp;
        bool _organico = product[farm][id][0].organico;
        product[farm][id].push(Farm(retailer,volume,date,local,_organico,ipfs_data_retailer, _id));
    }
    
    
    function getProduct(address farm, uint256 _id) public view returns ( Farm[] memory){
        _id = id;
        return product[farm][id];
    }
    
    function getId(address _farm) public view returns( uint256[] memory){
        return idProduct[_farm];
    }
    
} 
