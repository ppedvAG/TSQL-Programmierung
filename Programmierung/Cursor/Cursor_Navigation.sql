use Northwind;
GO

--Cursorname
--Der Name des der Transact-SQL Servercursor definiert. Cursor_name muss den Regeln f�r Bezeichner entsprechen.

--INSENSITIVE
--Definiert einen Cursor, der eine tempor�re Kopie der von ihm zu verwendenden Daten erzeugt. 
--Alle Anforderungen an den Cursor werden von dieser tempor�ren Tabelle in beantwortet Tempdb; 
--deshalb �nderungen an den Basistabellen werden nicht wiedergegeben, in den Daten, die durch
-- Abrufoperationen an diesem Cursor zur�ckgegeben, und l�sst dieser Cursor keine �nderungen. 
--Bei Verwendung der ISO-Syntax ohne die Option INSENSITIVE werden ausgef�hrte L�schvorg�nge 
--und Updates an den zugrunde liegenden Tabellen (von einem beliebigen Benutzer) in sp�teren Abrufvorg�ngen wiedergegeben.

--SCROLL
--Gibt an, dass alle Abrufoptionen (FIRST, LAST, PRIOR, NEXT, RELATIVE, ABSOLUTE) zur Verf�gung stehen. Wird SCROLL in einer ISO-DECLARE CURSOR-Anweisung nicht angegeben, wird nur die Abrufoption NEXT unterst�tzt. F�hren Sie einen BILDLAUF nicht angegeben oder FAST_FORWARD angegeben wird.
--select_statement
--Eine standardm��ige SELECT-Anweisung, die das Resultset des Cursors definiert. Die Schl�sselw�rter FOR BROWSE und INTO sind nicht zul�ssig in Select_statement der Deklaration eines Cursors.
--SQL Server Konvertiert den Cursor implizit in einen anderen Typ aus, wenn die Klauseln in Select_statement Konflikt mit der Funktionalit�t des angeforderten Cursortyps.
--READ ONLY
--Verhindert, dass �ber diesen Cursor Updates vorgenommen werden. Auf den Cursor kann nicht in einer WHERE CURRENT OF-Klausel in einer UPDATE- oder DELETE-Anweisung verwiesen werden. Diese Option �berschreibt die Standardeinstellung, nach der ein Cursor aktualisiert werden kann.
--UPDATE [OF Column_name [,...n]]
--Definiert aktualisierbare Spalten innerhalb des Cursors. Wenn OF Column_name [,... n] angegeben wird, k�nnen �nderungen nur die Spalten aufgef�hrt. Wenn UPDATE ohne Spaltenliste angegeben wird, k�nnen alle Spalten aktualisiert werden.
--Cursorname
--Der Name des der Transact-SQL Servercursor definiert. Cursor_name muss den Regeln f�r Bezeichner entsprechen.
--LOCAL
--Gibt an, dass der G�ltigkeitsbereich des Cursors lokal zu dem Batch, der gespeicherten Prozedur oder dem Trigger ist, in dem bzw. in der er erstellt wurde. Der Cursorname ist nur innerhalb dieses Bereichs g�ltig. Auf den Cursor kann durch lokale Cursorvariablen im Batch, in der gespeicherten Prozedur, im Trigger oder im OUTPUT-Parameter einer gespeicherten Prozedur verwiesen werden. Ein OUTPUT-Parameter kann den lokalen Cursor an den aufrufenden Batch, die aufrufende gespeicherte Prozedur oder den aufrufenden Trigger zur�ckgeben. Diese k�nnen den Parameter einer Cursorvariablen zuweisen, um nach dem Beenden der gespeicherten Prozedur auf den Cursor zu verweisen. Die Zuordnung des Cursors wird implizit aufgehoben, wenn der Batch, die gespeicherte Prozedur oder der Trigger beendet wird, es sei denn, der Cursor wurde in einem OUTPUT-Parameter zur�ckgegeben. Wenn sie in einer OUTPUT-Parameter �bergeben wird, wird der Cursor Zuordnung aufgehoben werden, wenn die letzten auf ihn verweisenden Variablen aufgehoben wird oder den G�ltigkeitsbereich verl�sst.
--GLOBAL
--Gibt an, dass der Bereich des Cursors global zur Verbindung ist. Auf den Cursornamen kann in jeder gespeicherten Prozedur und in jedem Batch verwiesen werden, die bzw. der von der Verbindung ausgef�hrt wird. Die Zuordnung des Cursors wird nur implizit aufgehoben, wenn die Verbindung getrennt wird.


Declare @Firma as varchar(50)
Declare @KDID as varchar(50)

Declare demoCursor SCROLL CURSOR For
Select Companyname, customerid from customers where Country = 'Germany'

Open  DemoCursor
FETCH LAST FROM democursor

FETCH PRIOR FROM democursor

FETCH ABSOLUTE 2 FROM democursor

FETCH RELATIVE 3 FROM democursor

FETCH relative -2 FROM democursor

close democursor
deallocate demoCuros