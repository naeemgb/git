import requests
import types
# import urllib.request
# import time
from bs4 import BeautifulSoup

class Tournament:
    def __init__(self):
        self._clubs = {}
        self._match = {}
        self.hamPath = []
        # for i in clubs:
        #     club = {i:[]}
        #     self._clubs.update(club)

    def membership(self,loser,winner):
        self._clubs.update({loser:[winner]})
        return

    def check_match(self,club):
        if(club in self._match):
            return False

        return True

    def count_clubs_match(self,loser,winner):
        if (self.check_match(loser)):
            self._match.update({loser:1})

        else:
            self._match[loser] += 1

        if(self.check_match(winner)):
            self._match.update({winner:1})

        else:
            self._match[winner] += 1

    def addEdge(self,loser,winner):
        if( (loser in self._clubs and winner in self._clubs[loser] ) or (winner in self._clubs and loser in self._clubs[winner])):
            raise ValueError('In half seasons,same both team cannot have second match')

        self.count_clubs_match(loser,winner)

        if( loser not in self._clubs ):
           self.membership(loser,winner)
           return 

        self._clubs[loser].append(winner)


    def hamilton_path(self,path,adj,pos):
        if pos == len(self._clubs):
            self.hamPath = path.copy()
            return True

        for club in adj:
            if club not in path :
                path.append(club)
                if(self.hamilton_path(path.copy(),self._clubs[club],pos+1)):
                    return True
                path.pop()
        return False

    def find_hamilton_path(self):

        path = []
        pos = 0
        for club in tournament._clubs:
            path = []
            path.append(club)

            if self.hamilton_path(path.copy(),tournament._clubs[club],pos+1):
                print(len(self.hamPath))
                break

        print(self.hamPath)
        
tournament = Tournament()

def analyze_match(clubs,score):
    team_score = score.string.split('-')
    fteam_score = team_score[0].split()[0]
    steam_score = team_score[1].split()[0]
    
    if(fteam_score == '?' or steam_score == '?'):#postpone match to another time
        return

    if(int(fteam_score) > int(steam_score)):
        tournament.addEdge(clubs[1].string,clubs[0].string)
    else:             # if lose or equal
        tournament.addEdge(clubs[0].string,clubs[1].string)

def analyze_data(content):
    
    _classDate = 'bt0'
    _date = ' December 15, 2018 '
    _classMatch = 'row-gray'
    for tag in content.contents:
        if tag == ' ':
            continue
        
        if _classDate in tag['class']:
            date = tag.find('div',class_="tright")

            if(date.string == _date):
                break
        
        if _classMatch in tag['class']:
            clubs = tag.find_all('div', class_="ply")
            score = tag.find('a',class_="scorelink")

            if(score == None):
                score = tag.find('div',class_="sco")

            analyze_match(clubs,score)


def check_tournament():
    number_of_match = len(tournament._clubs) - 1
    for club in tournament._match:
        if(tournament._match[club] is not number_of_match):
            raise ValueError('number of match is not correct for: '+club)
            

if __name__ == "__main__":
    url = 'http://www.livescores.com/soccer/iran/persian-gulf-league/results/all/'
    response = requests.get(url)
    # print(response)
    # print(type(response))
    # print(response.status_code)
    # print(response.headers)
    # print(response.headers['content-type'])
    # print(response.text)
    soup = BeautifulSoup(response.text,'html.parser')
    content = soup.find_all('div',class_="content",limit=1)

    try:
        analyze_data(content[0])
        check_tournament()
        
    except ValueError as e:
        print('Error:', e)    

    else:
        # print(tournament._clubs,file=outfile)
        tournament.find_hamilton_path()
    # print('done')   
    
    # content = soup.find_all('div',class_="row-gray")
    # clubs = content[0].find_all('div', class_="ply")
    # score = content[0].find_all('a',class_="scorelink")
    # # for child in _content[0].children:
        

    # print(clubs[1].string)
    # print(score[0].string.split('-'))




