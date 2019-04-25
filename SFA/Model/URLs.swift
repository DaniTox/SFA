//
//  URLs.swift
//  SFA
//
//  Created by Dani Tox on 23/12/18.
//  Copyright © 2018 Dani Tox. All rights reserved.
//

import Foundation

struct URLs {
    #if arch(x86_64)
        static let mainUrl = "http://localhost:5000"
    #else
        static let mainUrl = "http://api.suppstudenti.com:5000"
//        static let mainUrl = "http://192.168.1.77:5000"
    #endif
    
        static let calendarioURL = "https://calendar.google.com/calendar/embed?src=calendario@salesiani-ile.org&color=%23A32929&src=salesiani-ile.org_m8ep8fvvgg6tcqeioe9mkressg@group.calendar.google.com&color=%23B1365F&src=salesiani-ile.org_u5969o21d5mi0tudjomlq9hnvo@group.calendar.google.com&color=%237A367A&src=salesiani-ile.org_pql8ca5t2b23uoac4nvrt4g9t4@group.calendar.google.com&color=%235229A3&src=salesiani-ile.org_dn1qg5qkb359s7l4ts7427skcc@group.calendar.google.com&color=%2329527A&src=salesiani-ile.org_213b6s5kr725fmp9nhlo53hq58@group.calendar.google.com&color=%232952A3&src=salesiani-ile.org_bhbsjh07ve118qn4mqsr0eup18@group.calendar.google.com&color=%231B887A&src=salesiani-ile.org_c00t56e41b3sfhoreba9ju9754@group.calendar.google.com&color=%2328754E&src=salesiani-ile.org_90kchlu01jjnfjdbl2ns507mvs@group.calendar.google.com&color=%230D7813&src=salesiani-ile.org_81h3mpiecdmv29569ug3gq8i9k@group.calendar.google.com&color=%23528800&src=salesiani-ile.org_u54tn0tntab9ddip4lql09g068@group.calendar.google.com&color=%2388880E&src=salesiani-ile.org_aj6nqimgm8hhloai0el4slhe8s@group.calendar.google.com&color=%23AB8B00&src=salesiani-ile.org_n27im05dnubqi6499nlkijpl4s@group.calendar.google.com&color=%23BE6D00&src=salesiani-ile.org_h8b9ner11dc59ht9oglkac4vfc@group.calendar.google.com&color=%23B1440E&src=salesiani-ile.org_ep320295u02hgs4dv5jtqr1tmk@group.calendar.google.com&color=%23865A5A&src=salesiani-ile.org_qs3qetrgph23lmdfincodaa7g0@group.calendar.google.com&color=%23705770&src=salesiani-ile.org_4j2qsptdi7fi30c693rc5kec1k@group.calendar.google.com&color=%234E5D6C&src=salesiani-ile.org_psdg01m8vequlprtn2n2a89rm0@group.calendar.google.com&color=%234E8D6C&src=salesiani-ile.org_aeg9rpolr2d42tjvt3u4vg2mgs@group.calendar.google.com&color=%235A6986&src=salesiani-ile.org_psmofdufsab96thfssbe3rs96c@group.calendar.google.com&color=%234A716C&src=it.christian%23holiday@group.v.calendar.google.com&color=%236E6E41&src=it.italian%23holiday@group.v.calendar.google.com&color=%236E6E41&ctz=Europe/Rome&showTitle=1&showNav=1&showDate=1&showTabs=1&showCalendars=1&hl=it"
}
