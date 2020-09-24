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

app.listen(5000);
