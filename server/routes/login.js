const express = require("express");
const User = require("../models/User");
const router = express.Router();

//authentication
router.post("/", async (req, res) => {
  // var user = req.body.email;
  try {
    var alldata = await User.findOne({
      email: req.body.email,
    });
    if (alldata != null) {
      if (
        alldata.email != req.body.email ||
        alldata.password != req.body.password
      ) {
        res.json({ msg: "invalid username or password" });
      } else {
        res.json({ token: alldata._id });
      }
    }
    res.send({ "msg:": "invalid email" });

    ///res.json(alldata._id);
  } catch (err) {
    res.status(400).send(err);
  }

  //res.send("Welcome to login");
});

module.exports = router;
