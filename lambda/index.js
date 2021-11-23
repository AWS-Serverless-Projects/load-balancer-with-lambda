exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify('Hello from Lambda!'),
        headers: {
            'Content-Type': 'application/json'
        }
    };

    return response;
};
