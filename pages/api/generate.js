const generateAction = async (req, res) => {
  console.log('Received request')

  const input = JSON.parse(req.body).input;

  // Add fetch request to Hugging Face
  const response = await fetch(
    `https://api-inference.huggingface.co/models/jamestewartjr/jds-oe`,
    {
      headers: {
        Authorization: `Bearer ${process.env.HF_AUTH_KEY}`,
        'Content-Type': 'application/json',
      },
      method: 'POST',
      body: JSON.stringify({
        inputs: input,
      }),
    }
  );
  
  if (response.ok) {
    const buffer = await response.buffer();
    res.status(200).json({ image: buffer });
  } else if (response.status === 503) {
    const json = await response.json();
    res.status(503).json(json);
  } else {
    const json = await response.json();
    res.status(response.status).json({ error: response.statusText });
  }
}

export default generateAction;