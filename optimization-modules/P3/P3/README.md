# ConstPropVisitor — Reference Documentation

## Overview

`ConstPropVisitor` is an interprocedural conditional constant propagation optimizer for TACoJava programs. It extends `GJDepthFirst<String, Env>` and performs a full optimize-and-rewrite pipeline in a single call to `optimize(Goal)`. The pipeline has four major phases:

1. **Model collection** — scans the AST to build a structural model of all classes, fields, and methods.
2. **Worklist fixpoint** — propagates constant values interprocedurally across call edges until a stable state is reached.
3. **Reachability / side-effect analysis** — determines which methods are removable.
4. **Code rewrite** — emits optimized TACoJava, folding constants, eliminating dead branches, and pruning unused locals/methods/classes.

---

## Class Index

| Class | Kind | Description |
|---|---|---|
| `ConstPropVisitor` | outer class | Top-level optimizer; owns the pipeline and all shared state. |
| `ConstPropVisitor.Env` | inner (public static) | Per-analysis-unit environment mapping variable names to abstract values and types. |
| `ModelCollector` | private inner | `GJDepthFirst` visitor that populates the `ProgramModel` from the AST. |
| `ProgramModel` | private static | Structural model of the entire program (classes, methods, fields, inheritance). |
| `ClassInfo` | private static | Metadata for one class (name, parent, fields, methods). |
| `FieldInfo` | private static | Name + type of a single field. |
| `VarInfo` | private static | Name + type of a local variable or main-class local. |
| `MethodInfo` | private static | Full metadata for one method (owner, name, return type, params, locals, AST node). |
| `ParamInfo` | private static | Name + type of one formal parameter. |
| `MethodKey` | private static | Value-type key `(ownerClass, name)` used in all maps; implements `equals`/`hashCode`. |
| `MethodState` | private static | Per-method fixpoint state: formal abstract values, return value, reachability flag. |
| `CallerId` | private static | Worklist node: either the main unit or a specific method. |
| `CallEdge` | private static | One call site: set of possible dispatch targets + list of actual abstract values. |
| `AnalysisResult` | private static | Result returned from one analysis unit: call edges, return value, side-effect flag. |
| `AbsValue` | private static | Abstract lattice value with kinds `UNDEF`, `NAC`, `CONST_INT`, `CONST_BOOL`, `ARRAY`. |
| `ExprData` | private static | Result of evaluating one expression: rendered text, effect text, abstract value, static type, removability, call targets. |
| `Usage` | private interface | Callback interface for tracking variable/field/class/call usage during collection and reachability passes. |
| `CollectUsage` | private static | `Usage` impl that accumulates required locals, used fields, referenced classes, and call targets for emit. |
| `ReachabilityUsage` | private static | `Usage` impl that accumulates callee keys and observable-effect / loop flags for reachability analysis. |
| `OutputBase` | private abstract static | Base output record holding called methods, used fields, and used classes. |
| `MainOutput` | private static | Emit output for the main class body. |
| `MethodOutput` | private static | Emit output for one method body, including the return expression text. |
| `ReachabilityInfo` | private static | Reachability record: callee set, `hasObservableEffect`, `hasLoopKeepCondition`. |
| `RenderedStmt` | private interface | Marker interface for the structured IR used during dead-assignment cleanup. |
| `SimpleRenderedStmt` | private static | A single flat statement line. |
| `IfRenderedStmt` | private static | An if/else block with separate then- and else-statement lists. |
| `LoopRenderedStmt` | private static | A while or for loop with header and body statement list. |
| `BlockRenderedStmt` | private static | A bare `{ }` block. |
| `CleanupStmt` | private static | Result of cleaning one `RenderedStmt`: the (possibly null) cleaned statement and the live-variable set before it. |
| `CleanupBlock` | private static | Result of cleaning a list of `RenderedStmt`s: cleaned list and live-variable set on entry. |
| `AssignmentLine` | private static | Parsed simple assignment `target = rhs;` used during dead-assignment cleanup. |
| `ForHeader` | private static | Parsed for-loop header parts: `initTarget`, `initExpr`, `condExpr`, `stepExpr`. |
| `ParseCursor` | private static | Mutable cursor over a `List<String>` used when parsing rendered lines back into structured IR. |
| `ParseStop` | private enum | Stop condition for `parseRenderedStatements`: `END`, `BLOCK_END`, `IF_ELSE`. |
| `Tarjan` | private static | Tarjan's SCC algorithm over the call graph, used to identify recursive methods. |

---

## `ConstPropVisitor` — Fields & Methods

### Fields

| Field | Type | Description |
|---|---|---|
| `out` | `StringBuilder` (public final) | Accumulates the emitted optimized program text. |
| `model` | `ProgramModel` (private final) | Structural model built during phase 1. |
| `methodStates` | `Map<MethodKey, MethodState>` | Per-method fixpoint state, keyed by `MethodKey`. |
| `callersByCallee` | `Map<MethodKey, Set<CallerId>>` | Reverse call-graph edges for worklist re-enqueuing. |
| `reachabilityCache` | `Map<MethodKey, ReachabilityInfo>` | Cache of reachability results to avoid re-analysis. |
| `methodOutputCache` | `Map<MethodKey, MethodOutput>` | Cache of emit output per method, populated during rewrite. |
| `keptFieldsByClass` | `Map<String, Set<String>>` | Fields that appear live in emitted code, grouped by class name. |
| `keptClasses` | `Set<String>` | Classes that must appear in output. |
| `keptMethods` | `Set<MethodKey>` | Methods reachable from main that must appear in output. |
| `sideEffectMethods` | `Set<MethodKey>` | Methods determined to have observable side effects. |
| `nonRemovableMethods` | `Set<MethodKey>` | Methods whose calls cannot be elided (currently the same as `sideEffectMethods`). |
| `mainOutput` | `MainOutput` | Emit output for the main class, set during `rewriteProgram`. |
| `indent` | `int` | Current indentation depth for `emit`. |

### Public Methods

| Method | Signature | Description |
|---|---|---|
| `optimize` | `optimize(Goal root) → String` | Entry point: runs all four pipeline phases and returns the optimized program text. |

### Private Pipeline Methods

| Method | Signature | Description |
|---|---|---|
| `buildModel` | `buildModel(Goal root)` | Invokes `ModelCollector` to populate `model` from the AST. |
| `initializeStates` | `initializeStates()` | Creates a `MethodState` for every method, initializing all formals and the return value to `UNDEF`. |
| `runWorklist` | `runWorklist()` | Iterates the interprocedural worklist until no more changes propagate; processes main and each method in turn. |
| `meetActualsIntoCallees` | `meetActualsIntoCallees(CallEdge edge) → boolean` | Merges actual argument values into callee formal states; marks callee reachable; returns `true` if anything changed. |
| `analyzeMainUnit` | `analyzeMainUnit() → AnalysisResult` | Simulates the main method body and returns the resulting `AnalysisResult`. |
| `analyzeMethodUnit` | `analyzeMethodUnit(MethodKey key) → AnalysisResult` | Simulates one method body, evaluates its return expression, and returns the `AnalysisResult`. |
| `filterReturnValue` | `filterReturnValue(String returnType, AbsValue value) → AbsValue` | Coerces a return abstract value to `NAC` if it does not match the declared return type. |
| `computeNonRemovableMethods` | `computeNonRemovableMethods()` | Populates `nonRemovableMethods` from `sideEffectMethods`. |
| `computeReachability` | `computeReachability(MethodKey key) → ReachabilityInfo` | Runs `ReachabilityUsage`-driven simulation of a method and caches the result. |
| `rewriteProgram` | `rewriteProgram()` | Drives the emit phase: rewrites main, then BFS-expands reachable methods, then emits all kept classes. |
| `rewriteMain` | `rewriteMain() → MainOutput` | Runs collect + emit passes over main and finalizes the output. |
| `rewriteMethod` | `rewriteMethod(MethodKey key) → MethodOutput` | Runs collect + emit passes over one method and finalizes the output. |
| `finalizeMainOutput` | `finalizeMainOutput(MainOutput output)` | Applies dead-assignment cleanup to main's rendered lines and refreshes used classes/methods. |
| `finalizeMethodOutput` | `finalizeMethodOutput(MethodInfo method, MethodOutput output)` | Applies dead-assignment cleanup to a method's rendered lines and refreshes used classes/methods. |

### Simulation Methods

| Method | Signature | Description |
|---|---|---|
| `simulateStatementList` | `simulateStatementList(NodeListOptional, Env, AnalysisResult)` | Iterates and simulates each statement in a list. |
| `simulateStatement` | `simulateStatement(Node, Env)` | Dispatches on statement kind and updates the environment. |
| `simulateIf` | `simulateIf(IfStatement, Env)` | Folds a constant-condition branch; otherwise forks env for then/else and merges. |
| `simulateWhile` | `simulateWhile(WhileStatement, Env)` | Skips dead loops; otherwise iterates to a fixpoint by merging pre- and post-body envs. |
| `simulateFor` | `simulateFor(ForStatement, Env)` | Simulates for-loop init, skips dead loops, and iterates to a fixpoint. |
| `simulateReachableStatements` | `simulateReachableStatements(NodeListOptional, Env, ReachabilityUsage)` | Like `simulateStatementList` but also tracks observable effects and loop conditions. |
| `simulateReachableStatement` | `simulateReachableStatement(Node, Env, ReachabilityUsage)` | Variant of `simulateStatement` that also feeds `ReachabilityUsage` callbacks. |
| `markAnalysisSideEffect` | `markAnalysisSideEffect(Env)` | Sets `hasSideEffect = true` on the current `AnalysisResult`. |
| `assignValue` | `assignValue(Env, String name, AbsValue)` | Writes a value into the env, coercing to `NAC` if type or kind is incompatible. |
| `invalidateArray` | `invalidateArray(Env, String name)` | Sets an array local to `NAC` after an element assignment. |

### Expression Evaluation Methods

| Method | Signature | Description |
|---|---|---|
| `evalExpression` | `evalExpression(Expression, Env, Usage) → ExprData` | Evaluates any full expression node, folding constants where possible. |
| `evalConstOrId` | `evalConstOrId(ConstOrId, Env, Usage) → ExprData` | Evaluates a literal or identifier, substituting the constant's text if known. |
| `evalPrimary` | `evalPrimary(PrimaryExpression, Env, Usage) → ExprData` | Evaluates a primary expression (literal, `this`, `new`, `!`, identifier). |
| `evalIdentifier` | `evalIdentifier(Identifier, Env, Usage) → ExprData` | Looks up a name's abstract value; replaces with literal text if constant. |
| `evalIntegerLiteral` | `evalIntegerLiteral(IntegerLiteral) → ExprData` | Parses plain, `+`-signed, and `-`-signed integer literals. |
| `evalMessageSend` | `evalMessageSend(MessageSend, Env, Usage) → ExprData` | Evaluates a method call: collects dispatch targets, propagates actuals, looks up known return values. |

### Collection & Emit Methods

| Method | Signature | Description |
|---|---|---|
| `collectStatementList` | `collectStatementList(NodeListOptional, Env, CollectUsage)` | Iterates statements and accumulates usage information. |
| `collectStatement` | `collectStatement(Node, Env, CollectUsage)` | Dispatches on statement kind and records variable/field/call usage. |
| `collectAssignedNames` | `collectAssignedNames(Node, Set<String>)` | Recursively collects all variable names written to inside a statement or block. |
| `emitStatementList` | `emitStatementList(NodeListOptional, Env, CollectUsage, OutputBase) → List<String>` | Emits optimized lines for each statement in a list. |
| `emitStatement` | `emitStatement(Node, Env, CollectUsage, OutputBase) → List<String>` | Emits optimized lines for one statement, folding constants, eliminating dead branches and dead assignments. |
| `emitStructuredBody` | `emitStructuredBody(Statement, Env, CollectUsage, OutputBase) → List<String>` | Emits the body of an if/while/for, unwrapping a block if needed. |
| `emitMain` | `emitMain(MainOutput)` | Writes the main class header, kept locals, and body lines to `out`. |
| `emitClass` | `emitClass(ClassInfo)` | Writes a class declaration with kept fields and kept methods to `out`. |
| `emitMethod` | `emitMethod(MethodInfo, MethodOutput)` | Writes a method declaration with kept locals, body lines, and return statement to `out`. |
| `emit` | `emit(String line)` | Appends one indented line to `out`. |

### Cleanup & Liveness Methods

| Method | Signature | Description |
|---|---|---|
| `cleanupRenderedLines` | `cleanupRenderedLines(List<String>, Set<String> names, Set<String> liveAfter) → List<String>` | Parses flat lines into structured IR, runs liveness-based cleanup, re-renders to lines. |
| `cleanupRenderedStatements` | `cleanupRenderedStatements(List<RenderedStmt>, Set<String>, Set<String> liveAfter) → CleanupBlock` | Backward sweep over a statement list; removes dead assignments while preserving call effects. |
| `cleanupRenderedStatement` | `cleanupRenderedStatement(RenderedStmt, Set<String>, Set<String> liveAfter) → CleanupStmt` | Cleans one rendered statement, computing `liveBefore` from `liveAfter`. |
| `parseRenderedStatements` | `parseRenderedStatements(ParseCursor, ParseStop) → List<RenderedStmt>` | Parses emitted text lines back into a structured `RenderedStmt` tree. |
| `renderRenderedStatements` | `renderRenderedStatements(List<RenderedStmt>, int depth) → List<String>` | Re-serializes a `RenderedStmt` tree into indented text lines. |
| `mentionedLocals` | `mentionedLocals(List<String> lines, Set<String> names) → Set<String>` | Returns the subset of `names` that appear as words in the given lines. |
| `addMentionedNames` | `addMentionedNames(String text, Set<String> out, Set<String> names)` | Adds to `out` any name from `names` that appears as a whole word in `text`. |
| `addMentionedNamesExcept` | `addMentionedNamesExcept(String, Set<String>, Set<String>, String excluded)` | Like `addMentionedNames` but skips one excluded name. |
| `addLoopMentions` | `addLoopMentions(LoopRenderedStmt, Set<String>, Set<String>)` | Collects name mentions from a loop header and body, handling for-loop init-variable scoping. |
| `containsWord` | `containsWord(String text, String name) → boolean` | Returns true if `name` appears in `text` as a complete identifier (not a substring of another word). |
| `looksLikeMethodCall` | `looksLikeMethodCall(String rhs) → boolean` | Heuristic: true if the RHS string looks like a method call expression. |
| `looksLikeAllocation` | `looksLikeAllocation(String rhs) → boolean` | Heuristic: true if the RHS string starts with `new `. |
| `parseSimpleAssignment` | `parseSimpleAssignment(String line, Set<String> names) → AssignmentLine` | Parses `target = rhs;` from a line if target is a known name; returns `null` otherwise. |
| `parseForHeader` | `parseForHeader(String header) → ForHeader` | Splits a for-loop header string into init, cond, and step parts. |
| `shouldSeparateCallEffect` | `shouldSeparateCallEffect(ExprData) → boolean` | Returns true when a call's side-effect text must be emitted separately from the constant-folded result text. |
| `indentLine` | `indentLine(String text, int depth) → String` | Prepends `depth * 4` spaces to a line. |

### Class / Field Tracking Helpers

| Method | Signature | Description |
|---|---|---|
| `keptClassesFromMethodsAndMain` | `keptClassesFromMethodsAndMain() → Set<String>` | Collects all classes referenced by main or any kept method. |
| `addAncestorsOfKeptClasses` | `addAncestorsOfKeptClasses()` | Transitively adds parent classes of all kept classes until stable. |
| `addKeptField` | `addKeptField(String fieldRef)` | Parses `ClassName.fieldName` and records the field and its class as kept. |
| `hasKeptField` | `hasKeptField(String className) → boolean` | Returns true if any field in the class is kept. |
| `hasKeptMethodInClass` | `hasKeptMethodInClass(String className) → boolean` | Returns true if any kept method belongs to the class. |
| `markClassFromType` | `markClassFromType(String type)` | Adds `type` to `keptClasses` if it is a user-defined class (not a primitive or array). |
| `refreshUsedClasses` | `refreshUsedClasses(OutputBase, List<String>)` | Rescans emitted lines for `new ClassName()` patterns to refresh `usedClasses`. |
| `refreshCalledMethods` | `refreshCalledMethods(OutputBase, List<String>, String currentClass, Map<String,String> typeMap)` | Rescans emitted lines to rebuild the `calledMethods` set from dispatch-resolved method names. |
| `collectCalledMethodsFromLine` | `collectCalledMethodsFromLine(Set<MethodKey>, String line, String, Map<String,String>)` | Parses one rendered line for `receiver.method(` patterns and resolves dispatch targets. |
| `typeToString` | `typeToString(Type) → String` | Converts an AST `Type` node to its string form (`"int"`, `"boolean"`, `"int[]"`, or class name). |
| `createLoopRenderEnv` | `createLoopRenderEnv(Env base, Statement body, String extraAssigned) → Env` | Creates a rendering environment for a loop body by setting all assigned-to variables to `NAC`. |

---

## `Env` — Fields & Methods

Represents the abstract variable environment for one analysis unit (main or a method body).

### Fields

| Field | Type | Description |
|---|---|---|
| `className` | `String` | The class this environment belongs to (`this` type). |
| `model` | `ProgramModel` | Back-reference to the program model for field resolution. |
| `types` | `Map<String, String>` | Maps variable names to their declared types. |
| `values` | `Map<String, AbsValue>` | Maps variable names to their current abstract values. |
| `localNames` | `Set<String>` | Names declared as local variables. |
| `paramNames` | `Set<String>` | Names declared as formal parameters. |
| `fieldNames` | `Set<String>` | Names of fields visible in this scope. |
| `analysisResult` | `AnalysisResult` | Mutable result accumulator shared with the enclosing simulation. |

### Methods

| Method | Signature | Description |
|---|---|---|
| `forMain` | `static forMain(ProgramModel) → Env` | Constructs an environment for the main class body with all main locals initialized to `UNDEF`. |
| `forMethod` | `static forMethod(ProgramModel, MethodInfo, Map<String,AbsValue> inputs) → Env` | Constructs an environment for a method with fields at `NAC`, params from `inputs`, and locals at `UNDEF`. |
| `copy` | `copy() → Env` | Deep-copies this environment, sharing the `analysisResult` reference. |
| `mergeFrom` | `mergeFrom(Env left, Env right)` | Applies lattice meet to merge two environments into `this` (join point). |
| `sameValues` | `sameValues(Env other) → boolean` | Returns true if this env's value map equals another's (fixpoint check). |
| `lookupType` | `lookupType(String name) → String` | Returns the declared type of a variable, or `null`. |
| `lookupValue` | `lookupValue(String name) → AbsValue` | Returns the abstract value of a variable, defaulting to `NAC` if unknown. |
| `isField` | `isField(String name) → boolean` | Returns true if the name is a field in scope. |
| `isLocalOrParam` | `isLocalOrParam(String name) → boolean` | Returns true if the name is a local variable or formal parameter. |
| `resolveFieldOwner` | `resolveFieldOwner(String fieldName) → String` | Walks the inheritance chain from `className` to find the class that declares the field. |

---

## `AbsValue` — Fields & Methods

Represents a value on the constant propagation lattice. The partial order is:  
`UNDEF` (bottom) < `CONST_*` / `ARRAY` < `NAC` (top).

### Fields

| Field | Type | Description |
|---|---|---|
| `kind` | `Kind` (enum) | One of `UNDEF`, `NAC`, `CONST_INT`, `CONST_BOOL`, `ARRAY`. |
| `intValue` | `Integer` | Integer constant payload (non-null only when `kind == CONST_INT`). |
| `boolValue` | `Boolean` | Boolean constant payload (non-null only when `kind == CONST_BOOL`). |
| `arrayLength` | `Integer` | Known array length (non-null only when `kind == ARRAY` and length is statically known). |

### Factory Methods

| Method | Signature | Description |
|---|---|---|
| `undef` | `static undef() → AbsValue` | Bottom element — variable not yet assigned. |
| `nac` | `static nac() → AbsValue` | Top element — Not A Constant (value is unknown or conflicted). |
| `constInt` | `static constInt(int) → AbsValue` | Constant integer value. |
| `constBool` | `static constBool(boolean) → AbsValue` | Constant boolean value. |
| `array` | `static array(Integer length) → AbsValue` | Array value with optional known length. |

### Instance Methods

| Method | Signature | Description |
|---|---|---|
| `meet` | `static meet(AbsValue left, AbsValue right) → AbsValue` | Lattice meet: returns `UNDEF` if either is `null`/`UNDEF`; `NAC` if either is `NAC` or kinds differ; the constant if both are equal constants. |
| `renderLiteral` | `renderLiteral() → String` | Returns the source-code literal string for a constant, or `null` for `UNDEF`/`NAC`/`ARRAY`. |

---

## `ProgramModel` — Fields & Methods

### Fields

| Field | Type | Description |
|---|---|---|
| `classes` | `LinkedHashMap<String, ClassInfo>` | All classes in declaration order. |
| `methodsInOrder` | `List<MethodInfo>` | All methods across all classes, in declaration order. |
| `mainClass` | `MainClass` | AST node for the main class. |
| `mainClassName` | `String` | Identifier of the main class. |
| `mainArgName` | `String` | Parameter name of `main(String[] ...)`. |
| `mainLocals` | `List<VarInfo>` | Local variables declared in main, in order. |

### Methods

| Method | Signature | Description |
|---|---|---|
| `clear` | `clear()` | Resets all model state (called at the start of `optimize`). |
| `ensureClass` | `ensureClass(String name) → ClassInfo` | Returns or creates the `ClassInfo` for a class name. |
| `resolveDeclaredMethod` | `resolveDeclaredMethod(String className, String methodName) → MethodInfo` | Walks up the inheritance chain to find the declaring class for a method. |
| `possibleDispatchTargets` | `possibleDispatchTargets(String staticType, String methodName) → LinkedHashSet<MethodKey>` | Returns all method keys reachable by virtual dispatch from a given static type. |
| `findMethodsByName` | `findMethodsByName(String methodName) → LinkedHashSet<MethodKey>` | Returns all methods with a given name, across all classes. |
| `isSubtype` | `isSubtype(String className, String parent) → boolean` | Returns true if `className` is the same as or a subclass of `parent`. |
| `collectFields` | `collectFields(String className) → List<FieldInfo>` | Returns all fields visible in a class, ordered from ancestor to descendant. |
| `resolveFieldOwner` | `resolveFieldOwner(String className, String fieldName) → String` | Walks the inheritance chain to find the class that declares a given field. |

---

## `Tarjan` — Fields & Methods

Implements Tarjan's Strongly Connected Components algorithm over the method call graph to identify recursive methods.

### Fields

| Field | Type | Description |
|---|---|---|
| `graph` | `Map<MethodKey, ReachabilityInfo>` | The call graph, mapping each method to its reachability info (which includes its callees). |
| `index` | `Map<MethodKey, Integer>` | DFS discovery index per node. |
| `lowlink` | `Map<MethodKey, Integer>` | Lowest discovery index reachable from a node's subtree. |
| `stack` | `ArrayDeque<MethodKey>` | DFS stack of nodes in the current SCC candidate. |
| `onStack` | `Set<MethodKey>` | Fast membership test for `stack`. |
| `nextIndex` | `int` | Counter for DFS discovery indices. |

### Methods

| Method | Signature | Description |
|---|---|---|
| `computeRecursiveMethods` | `computeRecursiveMethods() → Set<MethodKey>` | Runs the full SCC computation and returns the set of methods that belong to a non-trivial SCC or are self-recursive. |
| `strongConnect` | `strongConnect(MethodKey node, Set<MethodKey> recursive)` | Recursive DFS step that discovers SCCs and adds multi-member or self-referential ones to `recursive`. |

---

## `ModelCollector` — Methods

Inner `GJDepthFirst` visitor that populates `model` during phase 1.

| Method | Signature | Description |
|---|---|---|
| `visit(Goal, ...)` | `Void` | Delegates to main class and type declarations. |
| `visit(MainClass, ...)` | `Void` | Records main class name, arg name, and local variable declarations. |
| `visit(TypeDeclaration, ...)` | `Void` | Delegates to the concrete class choice. |
| `visit(ClassDeclaration, ...)` | `Void` | Creates `ClassInfo` for a non-extending class and recurses into its fields and methods. |
| `visit(ClassExtendsDeclaration, ...)` | `Void` | Creates `ClassInfo` for an extending class, records its parent, and recurses. |
| `visit(VarDeclaration, ...)` | `Void` | Adds a `FieldInfo` (at class scope) or a local `VarInfo` (at method scope) to the model. |
| `visit(MethodDeclaration, ...)` | `Void` | Creates a `MethodInfo`, collects its parameters and local declarations. |
| `collectParam` | `collectParam(FormalParameter, MethodInfo)` | Adds one `ParamInfo` to a method's parameter list. |

---

## `Usage` Interface — Methods

| Method | Signature | Description |
|---|---|---|
| `markVarUsage` | `markVarUsage(String name, Env env)` | Called when a variable is read; implementations record it as required or as a field reference. |
| `markFieldUsage` | `markFieldUsage(String ownerClass, String fieldName)` | Called when a field is accessed by owner class and name. |
| `markClassReference` | `markClassReference(String className)` | Called when a class name appears (e.g., in `new` or `this` expressions). |
| `recordCallTargets` | `recordCallTargets(Set<MethodKey> targets)` | Called after resolving a call site's dispatch targets. |

---

## Pipeline Summary

```
optimize(Goal)
 ├─ buildModel(root)              → populates ProgramModel via ModelCollector
 ├─ initializeStates()            → creates MethodState for each method (all UNDEF)
 ├─ runWorklist()                 → interprocedural fixpoint over call edges
 │    ├─ analyzeMainUnit()        → simulate main; collect CallEdges
 │    ├─ analyzeMethodUnit(key)   → simulate method; compute return value
 │    └─ meetActualsIntoCallees() → propagate actuals; re-enqueue on change
 ├─ computeNonRemovableMethods()  → mark side-effect methods as non-removable
 └─ rewriteProgram()
      ├─ rewriteMain()            → collect + emit + cleanup main
      ├─ rewriteMethod(key) × N   → BFS over calledMethods; collect + emit + cleanup each
      └─ emitClass(classInfo) × M → emit kept classes with kept fields and methods
```