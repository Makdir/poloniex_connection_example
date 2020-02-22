Example of connection to Poloniex private (trading) HTTP API Methods

This example demonstrates how to solve a situation with error {"error":"Invalid command."}. This mistake can get then you try to connect to private (trading) Poloniex API with non-curl HTTP tools, libs or packets. (All example in https://docs.poloniex.com/#private-http-api-methods use curl.) The problem could be solved by adding header "Content-Type" with "application/x-www-form-urlencoded" value.
