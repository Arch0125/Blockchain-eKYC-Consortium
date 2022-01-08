# Blockchain-eKYC-Consortium

The Project aims to create a blockchain based KYC system where the banks are part of the network and Customers can store their data in the blockchain. Since this system develops a consortium or a group the customer does not need to seperately do KYC for any other bank belonging to the same group. Every account is linked to ablockchain wallet which is used as a password and transactions would me made through wallets like MetaMask. The Data can be share with other bank only if it is approved by the Owner(Customer) as a form of transaction. Thus decentralisation is achieved. 

Although complete Decentralisation creates a different problem that is immutability. Let's say the customer changed his/her residence, then his accounts would be considered illegitimate by the maintainers of the blockchain since the current address doesn't match. To tackle with this problem, we are using a combination of data structure that is Array of Structs which stores data in the smart contracts but also allows to midfy it only with the permission of the customer. 

Hence, the security of Blockchain is achieved along with the flexibility and scalibility required.

# Tech Stack :
<img  src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white" />
<img  src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white" />
<img  src="https://img.shields.io/badge/JavaScript-323330?style=for-the-badge&logo=javascript&logoColor=F7DF1E" />
<img  src="https://https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white" />
<img  src="https://img.shields.io/badge/Solidity-e6e6e6?style=for-the-badge&logo=solidity&logoColor=black" />

# Requirements
1. Nodejs
2. npm
3. solc - v0.4.26 `npm install solc@0.4.26`
4. web3 - v0.20.1 `npm install web3@0.20.1`
5. ganache-cli

# Running the project on local machine :
1. Run `npm i`
2. Run `node init`
3. Copy the address and paste it in contractAddress inside ./js/contractDetails.js
4. Open index.js for Bank Portal
5. Open indexCustomer.js for Customer Portal

# Working 
1. The smart contract is deployed, the address is logged in the console.
2. The Bank creates a KYC record for the customer using a unique Username and makes the transaction using the bank's wallet address.
3. The Username is given to to the user to sign up on the customer portal and view KYC form.
4. When some other bank wants access to the KYC an approval request is sent to the Owner.
5. Once approved the other bank can also access it.

# Templates used :
1. Bootstrap Agency for Front-page
2. Bootstrap NavBar - Used in bank homepage, customer homepage
3. Bootstrap/jquery Form - Used in Add form, View form, Modify form


