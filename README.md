# Blockchain-eKYC-Consortium

The Project aims to create a blockchain based KYC system where the banks are part of the network and Customers can store their data in the blockchain. Since this system develops a consortium or a group the customer does not need to seperately do KYC for any other bank belonging to the same group. Every account is linked to ablockchain wallet which is used as a password and transactions would me made through wallets like MetaMask. The Data can be share with other bank only if it is approved by the Owner(Customer) as a form of transaction. Thus decentralisation is achieved. 

Although complete Decentralisation creates a different problem that is immutability. Let's say the customer changed his/her residence, then his accounts would be considered illegitimate by the maintainers of the blockchain since the current address doesn't match. To tackle with this problem, we are using a combination of data structure that is Array of Structs which stores data in the smart contracts but also allows to midfy it only with the permission of the customer. 

Hence, the security of Blockchain is achieved along with the flexibility and scalibility required.

Templates used :
>Bootstrap Agency
>>Bootstrap NavBar

# Requirements
1. Nodejs
2. npm
3. solc - v0.4.26 `npm install solc@0.4.26`
4. web3 - v0.20.1 `npm install web3@0.20.1`
5. ganache-cli
