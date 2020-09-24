const mongooes = require("mongoose");

const userSchema = new mongooes.Schema({

  name: {
    type: String,
    max: 50,
    required: true,
  },
  email: {
    type: String,
    max: 50,
    required: true,
  },
  password: {
    type: String,
    max: 50,
    required: true,
  },
});

module.exports = mongooes.model("User", userSchema);
