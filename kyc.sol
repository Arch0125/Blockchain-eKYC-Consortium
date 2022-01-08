pragma solidity ^0.4.4;

contract kyc {

    struct Customer {
        string uname;
        string dataHash;
        uint upvotes;
        address bank;
        string password;
    }


    struct Organisation {
        string name;
        address ethAddress;
        uint KYC_count;
        string regNumber;
    }

    struct Request {
        string uname;
        address bankAddress;
        bool isAllowed;
    }

    //Array of structs
    Customer[] allCustomers;


    Organisation[] allOrgs;


    Request[] allRequests;

    function ifAllowed(string Uname, address bankAddress) public payable returns(bool) {
        for(uint i = 0; i < allRequests.length; ++i) {
            if(stringsEqual(allRequests[i].uname, Uname) && allRequests[i].bankAddress == bankAddress && allRequests[i].isAllowed) {
                return true;
            }
        }
        return false;
    }

    
    function addRequest(string Uname, address bankAddress) public payable {
        for(uint i = 0; i < allRequests.length; ++ i) {
            if(stringsEqual(allRequests[i].uname, Uname) && allRequests[i].bankAddress == bankAddress) {
                return;
            }
        }
        allRequests.length ++;
        allRequests[allRequests.length - 1] = Request(Uname, bankAddress, false);
    }

    function allowBank(string Uname, address bankAddress, bool ifallowed) public payable {
        for(uint i = 0; i < allRequests.length; ++ i) {
            if(stringsEqual(allRequests[i].uname, Uname) && allRequests[i].bankAddress == bankAddress) {
                if(ifallowed) {
                    allRequests[i].isAllowed = true;
                } else {
                    for(uint j=i;j<allRequests.length-2; ++j) {
                        allRequests[i] = allRequests[i+1];
                    }
                    allRequests.length --;
                }
                return;
            }
        }
    }


    
    function stringsEqual(string storage _a, string memory _b) internal returns (bool) {
		bytes storage a = bytes(_a);
		bytes memory b = bytes(_b);
		if (a.length != b.length)
			return false;
		// @todo unroll this loop
		for (uint i = 0; i < a.length; i ++)
        {
			if (a[i] != b[i])
				return false;
        }
		return true;
	}



    function isPartOfOrg() public payable returns(bool) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == msg.sender)
                return true;
        }
        return false;
    }

    function addBank(string uname, address eth, string regNum) public payable returns(uint) {
        if(allOrgs.length == 0 || isPartOfOrg()) {
            allOrgs.length ++;
            allOrgs[allOrgs.length - 1] = Organisation(uname, eth, 200, 0, regNum);
            return 0;
        }

        return 7;
    }

    function removeBank(address eth) public payable returns(uint) {
        if(!isPartOfOrg())
            return 7;
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == eth) {
                for(uint j = i+1;j < allOrgs.length; ++ j) {
                    allOrgs[i-1] = allOrgs[i];
                }
                allOrgs.length --;
                return 0;
            }
        }
        return 1;
    }

    function addCustomer(string Uname, string DataHash) public payable returns(uint) {
        if(!isPartOfOrg())
            return 7;
        for(uint i = 0;i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname))
                return 2;
        }
        allCustomers.length ++;
        if(allCustomers.length < 1)
            return 1;
        allCustomers[allCustomers.length-1] = Customer(Uname, DataHash, 100, 0, msg.sender, "null");
        updateRating(msg.sender,true);
        return 0;
    }


    function removeCustomer(string Uname) public payable returns(uint) {
        if(!isPartOfOrg())
            return 7;
        for(uint i = 0; i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname)) {
                address a = allCustomers[i].bank;
                for(uint j = i+1;j < allCustomers.length; ++ j) {
                    allCustomers[i-1] = allCustomers[i];
                }
                allCustomers.length --;
                updateRating(a,false);
                return 0;
            }
        }
        return 1;
    }

    function modifyCustomer(string Uname,string DataHash) public payable returns(uint) {
        if(!isPartOfOrg())
            return 7;
        for(uint i = 0; i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname)) {
                allCustomers[i].dataHash = DataHash;
                allCustomers[i].bank = msg.sender;
                return 0;
            }
        }

        return 1;
    }


    function viewCustomer(string Uname) public payable returns(string) {
        if(!isPartOfOrg())
            return "Access denied!";
        for(uint i = 0; i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname)) {
                return allCustomers[i].dataHash;
            }
        }
        return "Customer not found in database!";
    }

    function updateRatingCustomer(string Uname, bool ifIncrease) public payable returns(uint) {
        for(uint i = 0; i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname)) {
                //update rating
                if(ifIncrease) {
                    allCustomers[i].upvotes ++;
                    allCustomers[i].rating += 100/(allCustomers[i].upvotes);
                    if(allCustomers[i].rating > 500) {
                        allCustomers[i].rating = 500;
                    }
                }
                else {
                    allCustomers[i].upvotes --;
                    allCustomers[i].rating -= 100/(allCustomers[i].upvotes + 1);
                    if(allCustomers[i].rating < 0) {
                        allCustomers[i].rating = 0;
                    }
                }
                return 0;
            }
        }
        return 1;
    }


    function updateRating(address bankAddress,bool ifAdded) public payable returns(uint) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == bankAddress) {
                if(ifAdded) {
                    allOrgs[i].KYC_count ++;
                    allOrgs[i].rating += 100/(allOrgs[i].KYC_count);
                    if(allOrgs[i].rating > 500) {
                        allOrgs[i].rating = 500;
                    }
                }
                else {
                    allOrgs[i].rating -= 100/(allOrgs[i].KYC_count + 1);
                    if(allOrgs[i].rating < 0) {
                        allOrgs[i].rating = 0;
                    }
                }
                return 0;
            }
        }
        return 1;
    }

    function checkBank(string Uname, address password) public payable returns(string) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == password && stringsEqual(allOrgs[i].name, Uname)) {
                return "0";
            }
        }
        return "null";
    }

    function checkCustomer(string Uname, string password) public payable returns(bool) {
        for(uint i = 0; i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname) && stringsEqual(allCustomers[i].password, password)) {
                return true;
            }
            if(stringsEqual(allCustomers[i].uname, Uname)) {
                return false;
            }
        }
        return false;
    }

    function setPassword(string Uname, string password) public payable returns(bool) {
        for(uint i=0;i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname) && stringsEqual(allCustomers[i].password, "null")) {
                allCustomers[i].password = password;
                return true;
            }
        }
        return false;
    }

    // Get Functions

    function getBankRequests(string Uname, uint ind) public payable returns(address) {
        uint j = 0;
        for(uint i=0;i<allRequests.length;++i) {
            if(stringsEqual(allRequests[i].uname, Uname) && j == ind && allRequests[i].isAllowed == false) {
                return allRequests[i].bankAddress;
            }
            j ++;
        }
        return 0x14e041521a40e32ed88b22c0f32469f5406d757a;
    }


    function getBankName(address ethAcc) public payable returns(string) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == ethAcc) {
                return allOrgs[i].name;
            }
        }
        return "null";
    }

    function getBankEth(string uname) public payable returns(address) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(stringsEqual(allOrgs[i].name, uname)) {
                return allOrgs[i].ethAddress;
            }
        }
        return 0x14e041521a40e32ed88b22c0f32469f5406d757a;
    }

    function getCustomerBankName(string Uname) public payable returns(string) {
        for(uint i = 0;i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname)) {
                return getBankName(allCustomers[i].bank);
            }
        }
    }

    function getBankReg(address ethAcc) public payable returns(string) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == ethAcc) {
                return allOrgs[i].regNumber;
            }
        }
        return "null";
    }

    function getBankKYC(address ethAcc) public payable returns(uint) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == ethAcc) {
                return allOrgs[i].KYC_count;
            }
        }
        return 0;
    }

    function getBankRating(address ethAcc) public payable returns(uint) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == ethAcc) {
                return allOrgs[i].rating;
            }
        }
        return 0;
    }

    function getCustomerBankRating(string Uname) public payable returns(uint) {
        for(uint i = 0;i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname)) {
                return getBankRating(allCustomers[i].bank);
            }
        }
    }

    function getCustomerRating(string Uname) public payable returns(uint) {
        for(uint i = 0; i < allCustomers.length; ++ i) {
            if(stringsEqual(allCustomers[i].uname, Uname)) {
                return allCustomers[i].rating;
            }
        }
        return 0;
    }

}