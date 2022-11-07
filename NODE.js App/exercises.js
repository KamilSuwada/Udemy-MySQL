const { faker } = require('@faker-js/faker');
// npm install @faker-js/faker --save-dev

var mysql = require('mysql');
// npm install mysql

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  database : 'join_us'
});


// GENERATION OF RANDOM USERS:

function generateRandomPerson() {
	return [faker.internet.email(), faker.date.past()];
}

function populateRandomUserData(count) {
	var data = [];
	for (var i = 0; i < count; i++) {
		data.push(generateRandomPerson());
	}
	return data;
}

function insertRandomUsers(count) {
	var data = populateRandomUserData(count);
	var query = 'INSERT INTO users (email, created_at) VALUES ?';
	connection.query(query, [data], function (err, results) {
		if (err) throw err;
		console.log(results);
	});
}


// EXERCISE 1:
// Find earliest date a user joined?

function findEarliestJoinDate() {
	var query = 'SELECT DATE_FORMAT(created_at, "%M %D %Y") AS date FROM users ORDER BY created_at ASC LIMIT 1';
	connection.query(query, function (err, results, fields) {
		if (err) throw err;
		console.log(results);
	});
}
findEarliestJoinDate();


// EXERCISE 2:
// Find email of the first user?

function findEarliestJoinDateEmail() {
	var query = 'SELECT * FROM users WHERE created_at = (SELECT MIN(created_at) FROM users)';
	connection.query(query, function (err, results, fields) {
		if (err) throw err;
		console.log(results);
	});
}
findEarliestJoinDateEmail();


// EXERCISE 3:
// Show number of users who joined in months?

function groupUsersByMonthJoined() {
	var query = 'SELECT DATE_FORMAT(created_at, "%M") AS date, COUNT(*) AS total FROM users GROUP BY date ORDER BY total DESC';
	connection.query(query, function (err, results, fields) {
		if (err) throw err;
		console.log(results);
	});
}
groupUsersByMonthJoined();


// EXERCISE 4:
// Find numnber of users who use @yahoo.com email?

function findYahooUsers() {
	var query = 'SELECT COUNT(*) as yahoo_users FROM users WHERE users.email LIKE "%@yahoo.com"';
	connection.query(query, function (err, results, fields) {
		if (err) throw err;
		console.log(results);
	});
}
findYahooUsers();


// EXERCISE 5:
// Find numnber of users of each email host?

function grupUsersByEmailProvider() {
	var query = 'SELECT CASE WHEN users.email LIKE "%@yahoo.com" THEN "yahoo" WHEN users.email LIKE "%@gmail.com" THEN "gmail" WHEN users.email LIKE "%@hotmail.com" THEN "hotmail" ELSE "other" END AS provider, count(*) as total_users FROM users GROUP BY provider ORDER BY total_users DESC';
	connection.query(query, function (err, results, fields) {
		if (err) throw err;
		console.log(results);
	});
}
grupUsersByEmailProvider();



connection.end();