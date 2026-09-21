select P.firstname, P.lastName, A.city , A.state from Person P
LEFT join Address A ON
P.personId=A.personId
