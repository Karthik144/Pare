const express = require("express");
const app = express();

const stripe = require("stripe")("sk_test_51NGLJGLYY9K9hzsbtF1vsP46EXqZ0rak848xFsED4N5nT0PlBQqw5S6x5eyhA4jY7WXQXZ7i8yc2wp9YGFwqEQqb0083QgPdNN");

app.use(express.static("public"))
app.use(express.json())

const calculateOrderAmount = (items) => {
    //sum up price of basket of items
    const orderAmount = items.reduce((total, item) => total + item.price, 0)
    return orderAmount
}

app.post("/create-payment-intent", async (req, res) => {
    const { items } = req.body;

    const paymentIntent = await stripe.paymentIntents.create({
        amount: calculateOrderAmount(items),
        currency: "usd",
        automatic_payment_methods: {
            enabled: true,
        }
    })

    res.send({
        clientSecret: paymentIntent.client_secret,
    })
})

app.listen(4242, () => console.log("Server running on port 4242!"))
