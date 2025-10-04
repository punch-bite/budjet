// Cette fonction est fournie par sqlite3.js
window.sqlite3InitModule().then(function(sqlite3) {
  // Le module est maintenant chargé.
  // 'sqlite3' est l'objet qui donne accès à toutes les fonctionnalités.
  console.log("SQLite3 est prêt !");

  // Pour une utilisation simple, vous pouvez le rendre global (facultatif)
  globalThis.sqlite3 = sqlite3;

  // Ici, vous pouvez commencer à créer des bases de données et exécuter des requêtes.
  // Par exemple, créer une nouvelle base de données en mémoire :
  const db = new sqlite3.oo1.DB();
  db.exec("CREATE TABLE IF NOT EXISTS depenses (id TEXT,type TEXT, nom TEXT, montant REAL, created_at DateTime);");
  db.exec("INSERT INTO depenses VALUES ('1','Dépense', 'Nourriture', 25.50, 2025-05-11);");
  console.log("Base de données et table créées !");
});