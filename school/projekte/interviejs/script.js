document.getElementById("interview-form").addEventListener("submit", function(event) {
    event.preventDefault(); // Verhindert das Neuladen der Seite

    // Holen der Eingabewerte
    const question = document.getElementById("question").value;
    const answer = document.getElementById("answer").value;

    // Validieren der Eingaben
    if (question.trim() === "" || answer.trim() === "") {
        alert("Bitte fülle alle Felder aus!");
        return;
    }

    // Ausgabe erstellen
    const responseList = document.getElementById("response-list");
    const listItem = document.createElement("li");
    listItem.innerText = `Q: ${question} - A: ${answer}`;

    // Hinzufügen zur Liste
    responseList.appendChild(listItem);

    // Felder zurücksetzen
    document.getElementById("question").value = "";
    document.getElementById("answer").value = "";
});
