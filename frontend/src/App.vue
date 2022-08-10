<template>
  <div v-if="isDrizzleInitialized" id="app">
    <h1>ICO</h1>
    <drizzle-account />
    <ICOInfo></ICOInfo>
    <hr>
    <Admin v-if="isAdminConnected"></Admin>
    <Investor v-else></Investor>
  </div>
  <div v-else>Lll</div>
</template>

<script>
import { mapGetters } from 'vuex';
import ICOInfo from './components/ICOInfo.vue';
import Admin from './components/Admin.vue';
import Investor from './components/Investor.vue';

export default {
  name: 'App',
  components: {
    ICOInfo,
    Admin,
    Investor    
  },
  data() {
    return {
      admin: ''
    }
  },
  computed: {
    ...mapGetters('drizzle', ['isDrizzleInitialized']),
    ...mapGetters('accounts', ['activeAccount']),
    ...mapGetters("contracts", ["getContractData"]),
    isAdminConnected() {
      return this.admin === this.activeAccount;
    }
  },
  async created() {
    let adminAddress = await this.getAdminAddress();
    if (adminAddress === 'loading') {
      adminAddress = await this.getAdminAddress();
    }
    
    this.admin = adminAddress;
  },
  methods: {
    async getAdminAddress() {
      let adminAddress = await this.getContractData({contract: "ICO", method: "admin"});      
      return adminAddress;
    }
  }
}
</script>