const express = require("express");
const router = express.Router();
const User = require("../models/User");

router.get("/", (req, res) => {
  res.send("Welcome to /register");
});

router.post("/",async (req, res) => {
  //res.json(req.body);
  try {
    const user = new User({
      name: req.body.name,
      email: req.body.email,
      password: req.body.password,
    });
    //res.json(user);
    const savedUser = await user.save();
    res.send({"token":savedUser._id});
  } catch (err) {
    res.status(400).send(err);
  }
});

module.exports = router;
