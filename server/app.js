const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const mongoose = require("mongoose");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded());

const registerRoute = require("./routes/register");
const loginRoute = require("./routes/login");
const User = require("./models/User");

app.use("/register", registerRoute);
app.use("/login", loginRoute);

//get specific user Data
app.get("/:userId", async (req, res) => {
  //res.send(req.params.userId);
  try {
    const loggedInUser = await User.findById(req.params.userId);
    res.json(loggedInUser);
  } catch (err) {
    res.status(400).send(err);
  }
});

//home
app.get("/", (req, res) => {
  // console.log("Welcome to Home");
  res.send("Welcome to Home");
});
mongoose.connect(
  "mongodb://viral:viral@socialmedia-shard-00-00.ulna4.mongodb.net:27017,socialmedia-shard-00-01.ulna4.mongodb.net:27017,socialmedia-shard-00-02.ulna4.mongodb.net:27017/viral?ssl=true&replicaSet=atlas-k5na4e-shard-0&authSource=admin&retryWrites=true&w=majority",

  { useNewUrlParser: true },
  () => console.log("Connected")
);
app.listen(5000);
