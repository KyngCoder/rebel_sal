

getQuiz() async {

    return questionList;
  }


const questionList = 
   [
    {
      "type": "text",
      "content": "Who founded the Rebel Salute festival?",
      "options": [
        {"label": "A", "text": "Bob Marley"},
        {"label": "B", "text": "Sean Paul"},
        {"label": "C", "text": "Tony Rebel", "correct": true},
        {"label": "D", "text": "Peter Tosh"}
      ]
    },
    {
      "type": "image",
      "content": "Select the symbol associated with the Rastafarian movement.",
      "options": [
        {"label": "A", "image": "lion_of_judah.jpg", "correct": true},
        {"label": "B", "image": "ethiopian_flag.jpg"},
        {"label": "C", "image": "cannabis_leaf.jpg"},
        {"label": "D", "image": "rasta_stripes.jpg"}
      ]
    },
    {
      "type": "text",
      "content": "Which artist is known for the hit song 'Get Busy'?",
      "options": [
        {"label": "A", "text": "Buju Banton"},
        {"label": "B", "text": "Beenie Man"},
        {"label": "C", "text": "Sean Paul", "correct": true},
        {"label": "D", "text": "Capleton"}
      ]
    }
  ];

