<template>
  <div class="section">
    <h1>Admin</h1>
    <div class="form-group">
      <h2>Start</h2>
      <drizzle-contract-form contractName="ICO" method="start" />
    </div>
    <div class="form-group">
      <h2>Whitelist</h2>
      <drizzle-contract-form contractName="ICO" method="whitelist" />
    </div>
    <div class="form-group">
      <h2>Release</h2>
      <drizzle-contract-form contractName="ICO" method="release" />
    </div>
    <div class="form-group">
      <h2>Withdraw</h2>
      <drizzle-contract-form contractName="ICO" method="withdraw" />
    </div>
  </div>
</template>

<script>


export default {
  name: 'Admin',
  components: {
    
  }
}
</script>