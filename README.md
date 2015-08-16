# Eventually-Consistent State Machine

A spike of a library for creating objects from a series of events applied to a state machine, where the events may arrive out of order.

Don't use this in production.

### Usage

The library presents a DSL for defining a state machine on a model. You can see an example in the constructor spec.

Once you've done this, you can fetch a `Constructor` object, which can initialize your model given a series of events. Events are allowed to be passed out of order, but if more than one possible ordering on the events is found, an exception will be raised.

### Future work

Part of the motivation for this work are datastores that allow not just out-of-order events, but also missing events. I'm not sure how to handle this yet. A generic solution is probably not possible because the semantics of a missing transition are domain specific. It therefore seems we need a way to specify e.g. "this missing transition can be filled in safely" versus "if this transition is missing that's an error".

### Limitations

Transitions in this state machine are named and correspond one-to-one with a specific graph edge. However, other state machine libraries such as AASM define transitions as a set of edges all pointing to a single vertex; thus, the calling code doesn't need to know the specific current state of an object -- it only needs to know that it is one of N states that can transition to the new state.

It's unclear to me how useful this generalization is in practice -- the calling code almost certainly knows the current state of the object when it transitions. Thus, if A and B can both transition to C, the difference is only between calling "A to C" or "B to C" versus "go to C".
