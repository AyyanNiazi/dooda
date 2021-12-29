import {useEffect, useState} from 'react';
import Box from "contracts/Box.json";
import MyNft from "contracts/MyNft.json";
import getWeb3 from "./getWeb3";

function App() {
  const [values, setValues] = useState( { 
    storageValue: 0, 
    web3: null, 
    accounts: null, 
    contract: null,
    nftContract: null,
    setNumber: 0,
    nftValue: undefined
  })
  
  const getContracts = async () => {
    try {
      // Get network provider and web3 instance.
      const web3 = await getWeb3();

      // Use web3 to get the user's accounts.
      const accounts = await web3.eth.getAccounts();
      
      // Get the contract instance.
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = Box.networks[networkId];
      const nft = MyNft.networks[networkId];
      console.log(nft, deployedNetwork, accounts, networkId)
      const instance = new web3.eth.Contract(
        Box.abi,
        deployedNetwork?.address,
      );
      const nftInstance = new web3.eth.Contract(
        MyNft.abi,
        nft?.address,
      );

      // Set web3, accounts, and contract to the state, and then proceed with an
      // example of interacting with the contract's methods.
      setValues( { ...values,  web3, accounts, contract: instance, nftContract: nftInstance });
    } catch (error) {
      // Catch any errors for any of the above operations.
      alert(
        `Failed to load web3, accounts, or contract. Check console for details.`,
      );
      console.error(error);
    }
  };

  const storeValue = async value => {

    // Stores a given value, 5 by default.
   const response = await values.contract.methods.store(value).send({ from: values.accounts[0] });
   console.log(response);
   getValue()

    // Get the value from the contract to prove it worked.
    
  }

  
  const getValue = async () => {
    if(!values.contract) return
    const response = await values.contract.methods.retrieve().call();
    const res = await values.nftContract.methods.uri(1).call();
    const owner = await values.nftContract.methods.owner().call();
    fetch(res)
    .then(res=> res.json())
    .then(data => setValues({ ...values, nftValue: {...data, owner} }) )
    // Update state with the result.
    // setValues({ ...values, storageValue: response, nftValue: res });
    console.log('get', response, res, owner)
  }

  useEffect(() => {
  getContracts()
  }, [])

  useEffect(() => {
    getValue()
  }, [values.contract])



  return (
    <div className="App">
        <img src={values.nftValue?.image} width="160" height="160" alt="NFT" />
        <h2> Nft Name:  {values.nftValue?.name} </h2>
        <h2> Token Id:  {values.nftValue?.tokenId} </h2>
        <h2> Owner:  {values.nftValue?.owner} </h2>
    </div>
  );
}

export default App;
