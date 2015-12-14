//
//  MyNewsDir.swift
//  Threads
//
//  Created by Igor Cova on 13/12/15.
//  Copyright © 2015 Igor Cova. All rights reserved.
//

import UIKit

class NewsDir: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIScrollViewDelegate {

    var dirNews = [Entry]()
    
    @IBOutlet weak var btnToMenu: UIBarButtonItem!
    @IBOutlet weak var tvNews: UITableView!
    var lastOffsetY : CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dirNews.isEmpty {
            self.fillNewsDir()
        }
        
        //self.navigationController?.hidesBarsOnSwipe = true
        //self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        
        self.tvNews.delegate = self
        self.tvNews.dataSource = self
        self.tvNews.separatorStyle = .None
        self.btnToMenu.target = self.revealViewController()
        self.btnToMenu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        self.lastOffsetY = scrollView.contentOffset.y
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView){
        let hide = scrollView.contentOffset.y > self.lastOffsetY
        self.navigationController?.setNavigationBarHidden(hide, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dirNews.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : EntryCell = (tableView.dequeueReusableCellWithIdentifier("NewsCell") as? EntryCell)!
        cell.setCell(dirNews[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let entry = dirNews[indexPath.row]
        let height : CGFloat = self.calculateHeightForString(entry.title)
        return height + 100.0
    }
    
    func calculateHeightForString(inString : String) -> CGFloat{
        let messageString = inString
        let attributes = [NSFontAttributeName: UIFont(name: "Lato", size: 17.0)!]
        let attrString: NSAttributedString? = NSAttributedString(string: messageString, attributes: attributes)
        let rect:CGRect = attrString!.boundingRectWithSize(CGSizeMake(300.0,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context:nil )
        let requredSize:CGRect = rect
        return requredSize.height
    }
    
    
    
    func fillNewsDir() {
        
        let e1 = Entry(id: 1, communityName: "Major Mafia", communityImg: "ComLogos/MajorMafia.png", columnName: "Post", date: "18.10.15 20:20", title: "Тестируем нормально")
        
        let e2 = Entry(id: 2, communityName: "Major Mafia", communityImg: "ComLogos/MajorMafia.png", columnName: "Post", date: "18.10.15 20:05", title: "Убу́нту (зулу ubuntu и коса ubuntu — человечность) — южноафриканское направление этики и гуманистической философии, особое внимание уделяющее понятиям верности и лояльности в отношениях между людьми. Убунту является одним из основополагающих принципов новой Южно-Африканской Республики. Его положения связываются с идеями Африканского Возрождения. Приблизительное толкование слова убунту — человечность по отношению к другим. Другой возможный вариант перевода — вера во вселенские узы общности, связывающие всё человечество")
        
        let e3 = Entry(id: 3, communityName: "Digital Tectonics", communityImg: "ComLogos/DigTec.jpg", columnName: "Mett", date: "14.10.15 20:01", title: "В нью-йоркской школе появляется таинственный ученик по имени Дэниэл. Он виртуозно владеет паркуром и сразу находит себе друзей по интересам, с которыми он может «летать» над городом, пока тот спит. Среди новых друзей прекрасная Эмили, которая безоглядно влюбляется в новичка. Но откуда приехал Дэниэл? Кто он такой? Где он жил раньше? Ведь у него полно секретов, которые он не доверяет своим друзьям. Но тайны прошлого не дремлют и Дэниэлу придётся бороться не только за свою жизнь, но и за жизнь своих новых друзей.")
        
        let e4 = Entry(id: 4, communityName: "Thread", communityImg: "ComLogos/thread.png", columnName: "Likes", date: "13.10.15 20:00", title: "Alberto Cova (born December 1, 1958) is a retired Italian long-distance track athlete, winner of the 10,000 m at the 1984 Summer Olympics.")
        
        let e5 = Entry(id: 5, communityName: "Major Mafia", communityImg: "ComLogos/MajorMafia.png", columnName: "Post", date: "11.10.15 19:54", title: "Пре́мия «То́ни» (англ. Tony Award) — популярное название премии, ежегодно присуждаемой за достижения в области американского театра, включая музыкальный театр (прежде всего многочисленные постановки на Бродвее, Нью-Йорк). Полное официальное название премии — «Antoinette Perry Award for Excellence in Theatre». Своё название премия получила в честь американской актрисы и режиссёра Антуанетты Перри (1888—1946).")
        
        let e6 = Entry(id: 6, communityName: "Digital Tectonics", communityImg: "ComLogos/DigTec.jpg", columnName: "Post", date: "10.10.15 19:00", title: "Andrew is the English form of a given name common in many countries. In the 1990s it was among the top ten most popular names for boys in English-speaking countries.[3] In Italian, the equivalent to 'Andrew' is 'Andrea', though 'Andrea' is feminine in most other languages. 'Andrew' is frequently shortened to 'Andy' or 'Drew'. The word is derived from the Greek: Ανδρέας, Andreas,[4] itself related to Ancient Greek: ἀνήρ/ἀνδρός aner/andros, 'man' (as opposed to 'woman'), thus meaning 'manly' and, as consequence, 'strong', 'courageous', and 'warrior'. In the King James Bible, the Greek 'Ἀνδρέας' is translated as Andrew")
        
        let e7 = Entry(id: 7, communityName: "Run Foundation", communityImg: "ComLogos/RunFoundation.png", columnName: "Likes", date: "8.10.15 20:050", title: "Apple Inc. (МФА: [ˈæp(ə)l ɪŋk]; официальное русское написание — «Эппл»[6]; apple в переводе с англ. — «яблоко») — американская корпорация, производитель персональных и планшетных компьютеров, аудиоплееров, телефонов, программного обеспечения. Один из пионеров в области персональных компьютеров[7] и современных многозадачных операционных систем с графическим интерфейсом. Штаб-квартира — в Купертино, штат Калифорния. Благодаря инновационным технологиям и эстетичному дизайну, корпорация Apple создала уникальную репутацию, сравнимую с культом, в индустрии потребительской электроники[8]. На 2014 год компания занимает первое место в мире по рыночной капитализации")
        
        let e8 = Entry(id: 8, communityName: "Major Mafia", communityImg: "ComLogos/MajorMafia.png", columnName: "Post", date: "8.10.15 10:00", title: "Bubas — род пластинчатоусых из подсемейства Scarabaeinae. Описание - Жуки относительно короткоовальные, сильно выпуклые. Окраска смоляно-чёрная, довольно блестящая. Верх тела почти голый, низ в длинных рыжих волосках. Лоб самцов с боковыми рогами (зубцами у слаборазвитых особей), самок — сильный, простой, дополнительно у самок имеется теменной бугорок. Усики 9-члениковые, базальный членик булавы слабо чашевидный. Переднеспинка сильно поперечная, более или менее сердцевидная, её основание в середине не окаймлено. Щиток рудиментарен и слабо различим. Основание переднегруди с направленным назад срединным шжлупим, Заднегрудь перед задними тазиками со слабым двойным вдавлением. Ноги короткие и толстые, передний голени самца слабо удлинены; средние и задние голени сильно расширены к вершинам.")
        
        let e9 = Entry(id: 9, communityName: "Major Mafia", communityImg: "ComLogos/MajorMafia.png", columnName: "News", date: "5.10.15 21:20", title: "Фишер бродит по лесным тропинкам (1985-1986). Жизнь чиновника Сергея Головкина представляла собой ежедневную рутину: работа с документами, важные, менее важные, совсем ненужные бумаги. Ежедневные поездки по одному и тому же маршруту дом — работа, работа – дом. Прошлое стало покрываться для него серой дымкой забвения. Какие могут быть такие опасные шалости с детьми? Он же серьезный взрослый человек. Летний отпуск 1985 года Сергей провел на Черном море в Пицунде. Валялся на пляже, даже поглядывал на загорающих женщин. На детей, впрочем, тоже поглядывал, но особенно не волновался. Вел себя паинькой, как иногда в школе. Его никто не ругал, и он чувствовал себя хорошо")
        
        dirNews.append(e1)
        dirNews.append(e2)
        dirNews.append(e3)
        dirNews.append(e4)
        dirNews.append(e5)
        dirNews.append(e6)
        dirNews.append(e7)
        dirNews.append(e8)
        dirNews.append(e9)
    }
}
