import ICO from '../../build/contracts/ICO'

const options = {
  web3: {
    block: false,
    fallback: {
      type: 'ws',
      url: 'ws://127.0.0.1:7545'
    }
  },
  contracts: [ICO],
  polls: {
    accounts: 15000
  }
}

export default options