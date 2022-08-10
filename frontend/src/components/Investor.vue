<template>
  <div class="section">
    <h1>Investor</h1>
    <div class="form-group">
      <h2>Get sales</h2>
      <drizzle-contract-form contractName="ICO" method="getSale" />
    </div>
    <div class="form-group">
      <h2>Buy</h2>
      <drizzle-contract-form contractName="ICO" method="buy" />
    </div>
  </div>
</template>

<script>


export default {
  name: 'Investor',
  components: {
    
  }
}
</script>