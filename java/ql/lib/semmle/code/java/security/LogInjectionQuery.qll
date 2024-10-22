/** Provides taint tracking configurations to be used in queries related to the Log Injection vulnerability. */

import java
import semmle.code.java.dataflow.FlowSources
import semmle.code.java.security.LogInjection


pragma[noinline]
predicate hasOverlay() { externalData(_, "/github/codeql/overlay-experiment", 0, "overlay") }

string getRawFile(Element el) { el.getLocation().hasLocationInfo(result, _, _, _, _) }

pragma[noinline] predicate discardable(string file, Element el) {
  not hasOverlay() and
  file = [getRawFile(el.(Expr)), getRawFile(el.(Stmt)), getRawFile(el.(LocalScopeVariable))]
}

pragma[noinline] predicate discard(string file) {
  hasOverlay() and
  exists(Expr e | exists(e.getEnclosingCallable()) and file = getRawFile(e))
}

pragma[nomagic] recompute
predicate discardElement(Element el) {
  exists(string file | discardable(file, el) and discard(file))
}

pragma[noinline] predicate discardNode(DataFlow::Node node) {
  discardElement(node.asExpr())
  or
  discardElement(node.(DataFlow::PostUpdateNode).getPreUpdateNode().asExpr())
  // TODO: add more cases
}

pragma[noinline] predicate discardPathNode(LogInjectionFlow::PathNode node) {
  discardNode(node.getNode())
}

/**
 * A taint-tracking configuration for tracking untrusted user input used in log entries.
 */
module LogInjectionConfig implements DataFlow::ConfigSig {
  recompute predicate isSource(DataFlow::Node source) { source instanceof ActiveThreatModelSource }

  recompute predicate isSink(DataFlow::Node sink) { sink instanceof LogInjectionSink }

  recompute predicate isBarrier(DataFlow::Node node) { node instanceof LogInjectionSanitizer or discardNode(node) }

  recompute predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    any(LogInjectionAdditionalTaintStep c).step(node1, node2)
  }

  recompute predicate isBarrierIn(DataFlow::Node node) { isSource(node) }
}

/**
 * Taint-tracking flow for tracking untrusted user input used in log entries.
 */
module LogInjectionFlow = TaintTracking::Global<LogInjectionConfig>;
