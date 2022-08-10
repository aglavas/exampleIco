<template>
  <div class="section">
    <h2>ERC20 Token</h2>
    <drizzle-contract contractName="ICO" method="tokenAdress" label="Token"/>
    <drizzle-contract contractName="ICO" method="endDate" label="End"/>
    <drizzle-contract contractName="ICO" method="initialPrice" label="Price"/>
    <drizzle-contract contractName="ICO" method="minPurchase" label="Minimal Purchase"/>
    <drizzle-contract contractName="ICO" method="maxPurchase" label="Maximum Purchase"/>
    <drizzle-contract contractName="ICO" method="availableTokens" label="Available Tokens"/>
    <drizzle-contract contractName="ICO" method="released" label="Released"/>
    <drizzle-contract contractName="ICO" method="admin" label="Admin"/>
  </div>
</template>

<script>
import { mapGetters } from 'vuex';

export default {
  name: 'ICOInfo',
  computed: mapGetters('accounts', ['activeAccount'])
}
</script>