import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);


const lectureSeat = {
  state: {
    x: 0,
    y: 0,
    confirmButtonLoading: false,
    reset: false
  },

  mutations: {
    changeX(state, x) {
      state.x = x
    },

    changeY(state, y) {
      state.y = y
    },

    changeConfirmButtonLoading(state, confirmButtonLoading) {
      state.confirmButtonLoading = confirmButtonLoading
    },

    changeReset(state, reset) {
      state.reset = reset
    }
  },

  actions: {
    clearLectureSeat({commit}) {
      return new Promise((resolve, reject) => {
        setTimeout(() => {
          commit('changeX', 0);
          commit('changeY', 0);
          commit('changeConfirmButtonLoading', false);
          commit('changeReset', false);
          resolve()
        }, 16)
      })
    }
  },

  getters: {}
};


const config = {
  state: {
    fullscreen: false
  },

  mutations: {
    makeFullscreen(state, fullscreen) {
      state.fullscreen = fullscreen
    }
  }
};


export default new Vuex.Store({
  modules: {
    lectureSeat,
    config
  }
});
