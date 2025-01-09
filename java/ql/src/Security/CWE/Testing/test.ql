/**
 * @name Bla
 * @description Bla
 * @kind problem
 * @id java/bla
 * @problem.severity error
 * @security-severity 7.5
 * @precision high
 * @tags security
 */

import java

query predicate methods2(Top m, string nodename, string signature, Top typeid, Top parentid, Top sourceid) {
  methods(m, nodename, signature, typeid, parentid, sourceid)
}


query predicate params2(Top id, Top typeid, int pos, Top parentid, Top sourceid) {
   params(id, typeid, pos, parentid, sourceid)
}

query predicate isAnnotType2(Top interfaceid) {
    isAnnotType(interfaceid)
}

query predicate isAnnotElem2(Top methodid) {
    isAnnotElem(methodid)
}

query predicate isAnnotElem3(Top methodid) {
    isAnnotElem(methodid)
}

query predicate annotValue2(Top parentid, Top id2, Top value) {
    annotValue(parentid, id2, value)
}

query predicate typeBounds2(Top id, Top typeid, int pos, Top parentid) {
    typeBounds(id, typeid, pos, parentid)
}

query predicate hasLocation2(Top l, Location loc) {
    hasLocation(l, loc)
}

select 1
