const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const mongoose = require("mongoose");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded());

const registerRoute = require("./routes/register");
const loginRoute = require("./routes/login");

app.use("/register", registerRoute);
app.use("/login", loginRoute);

//home
app.get("/", (req, res) => {
  // console.log("Welcome to Home");
  res.send("Welcome to Home");
});

//DB connection
mongoose.connect(
  "mongodb+srv://viral:viral@socialmedia.ulna4.mongodb.net/<?retryWrites=true&w=majority",
  { useNewUrlParser: true, useUnifiedTopology: true },
  () => console.log("connected")
);
app.listen(5000);
