Basically IO is a monad enabing two kinds of effects :

model modification: it is a state monad whose state is the model. It can be read by get and written by set.
Cmd and CmdM commands.
type alias IO model msg =
    IO model msg
Monadic interface for The Elm Architecture.

A value of type IO model a is an effectful computation that can modify the model model, perform commands and contains values of type a.

Runing a web application with IO

This module port the two main ways of running an Elm application to IO.

type alias Program flags model msg =
    Program flags model (IO model msg)
Program using IO.

sandbox :
    { init : flags -> ( model, IO model msg )
    , view : model -> Html (IO model msg)
    , subscriptions : model -> Sub (IO model msg)
    }
    -> Program flags model msg
Transform a sandbox program using IO into a normal sandbox program.

element :
    { init : flags -> ( model, IO model msg )
    , view : model -> Html (IO model msg)
    , update : msg -> IO model msg
    , subscriptions : model -> Sub (IO model msg)
    }
    -> Program flags model msg
Transform an element program using IO into a normal element program.

document :
    { init : flags -> ( model, IO model msg )
    , view : model -> Document (IO model msg)
    , update : msg -> IO model msg
    , subscriptions : model -> Sub (IO model msg)
    }
    -> Program flags model msg
Transform a document program using IO into a normal document program.

application :
    { init : flags -> Url -> Key -> ( model, IO model msg )
    , view : model -> Document (IO model msg)
    , update : msg -> IO model msg
    , subscriptions : model -> Sub (IO model msg)
    , onUrlRequest : UrlRequest -> IO model msg
    , onUrlChange : Url -> IO model msg
    }
    -> Program flags model msg
Transform an application program using IO into a normal application program.

Lifting values and commands into IO

pure : a -> IO model a
Returns an IO whose only effect is containing the value given to pure.

lift : Cmd a -> IO model a
Lift a Cmd as an IO.

liftM : CmdM a -> IO model a
Lift a CmdM into an IO

liftUpdate : (model -> ( model, Cmd a )) -> IO model a
Lift a classic update function into an IO.

The model as a state

get : IO model model
An IO that returns the current model.

set : model -> IO model ()
An IO that sets the model.

modify : (model -> model) -> IO model ()
A IO that modify the model.

Classic monadic operations

map : (a -> b) -> IO model a -> IO model b
Map a function over an IO.

Laws

map (f >> g) = (map f) >> (map g)
map identity = identity
andThen : (a -> IO model b) -> IO model a -> IO model b
Chains IOs.

If you have an IO model a and a function which given a a can give you an IO model b depending on the value of type a given to the function. Then andThen gives you an IO model b that will run the first IO and then apply the function.

Laws

andThen pure = identity
andThen (f >> pure) = map f
(andThen f) >> (andThen g) = andThen (a -> andThen g (f a))
join : IO model (IO model a) -> IO model a
Flatten an IO containing an IO into a simple IO.

Laws

join (pure m) = m
ap : IO model (a -> b) -> IO model a -> IO model b
Transform an IO containing functions into functions on IO It enable to easily lift functions to IO.

Laws

ap (pure identity) = identity
ap (pure (f >> g)) = ap (pure f) >> ap (pure g)
flap : IO model a -> IO model (a -> b) -> IO model b
Flipped version of ap. To be used like:

pure f |> flap arg1 |> flap arg2 ...
compose : (b -> IO m c) -> (a -> IO m b) -> a -> IO m c
Composition of monadic functions

seq : IO model b -> IO model a -> IO model b
Run the second argument, ignore the result, then run the first one. To be used in

first |> seq second
traverse : (a -> IO model b) -> List a -> IO model (List b)
You can think of traverse like a map but with effects. It maps a function performing IO effects over a list.

mapM : List (IO model a) -> IO model (List a)
Transform a list of IO into an IO of list.

Passing from a model to another via optics

lens : Lens b a -> IO a msg -> IO b msg
Congruence by a Lens on an IO.

It would be silly to force users to redefine every IO for each application model. Lenses enable to lift an IO action on a model a to the same IO but action on a model b.

You can then define your IO on the minimal model and lift them to you real application's model when needed.

optional : Optional b a -> IO a msg -> IO b msg
Congruence by a Optional on an IO. Just like lenses but with Optional. If the optional returns Nothing, then the IO does nothing.

iso : Iso b a -> IO a msg -> IO b msg
Congruence by a Iso on an IO. Just like lenses but with Iso.

prism : Prism b a -> IO a msg -> IO b msg
Congruence by a Prism on an IO. Just like lenses but with Prism. If the prism returns Nothing, then the IO does nothing.

replace : IO b a -> (a -> IO b ()) -> IO a x -> IO b x
Replace get and set by custom functions

Dummy values

none : IO model a
An IO doing nothing (an containing no values!).

dummyUpdate : a -> IO b c
Dummy update function.

dummySub : a -> Sub b
Dummy subscription function

Forces Elm rendering

yield : msg -> IO model msg
Identity function that forces Elm to render the current state. Is equivalent to sleep for 0 milliseconds.

forceRendering : IO a b -> IO a b
Forces Elm to render every set operation (model update). This is MUCH SLOWER than normal set operations.

Transform IO into regular Elm

transform :
    (msg -> IO model msg)
    -> { update : IO model msg -> model -> ( model, Cmd (IO model msg) )
       , initTransformer :
             ( model, IO model msg ) -> ( model, Cmd (IO model msg) )
       }
Transform a program using IO into a normal program.

Batch operations

Beware that batch operations might not do what you think. The execution order of messages and commands is not defined.

batch : List a -> IO model a
Send messages in batch mode

batchM : List (IO model a) -> IO model a
Its use is strongly discouraged! Use mapM instead! Combine a list of IO.
