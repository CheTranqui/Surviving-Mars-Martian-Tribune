# Martian Tribune: Mod for Surviving Mars

The Martian Tribune adds a newspaper popup every 3 days with stories based on what has been happening in the colony. It's described in detail [in this Youtube video](https://www.youtube.com/watch?v=QJvOHWFPZ_Y)

This mod can be downloaded from the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=1376913896), [NexusMods](https://www.nexusmods.com/survivingmars/mods/85), or direct from [github](https://github.com/CheTranqui/Surviving-Mars-Martian-Tribune).

## Interaction from other mods

It is possible for another mod to add stories to the queue for publishing in the Martian Tribune. The Martian Tribune provides functions to add/remove stories, to track whether a story has actually been published, and to retrieve the Sol on which it was published.  Please read below for the details on story creation and addition.

## Please limit the number of stories that you add to 3 or less in order to avoid bloat and maintain integrity of the Tribune's original purpose.

## Story Format

Stories should be defined in the following format:

```lua
{
    key = "AUniqueKeyString",
    title = T{1234567890, "Your story headline"},
    story = T{1234567891, "     The content of your story, with optional <Replacement> data", Replacement = SomeVariable},
}
```

Optionally, a `colonist` field with an actual colonist can also be provided which will cause the colonist to be pinned to the user's bar when the story gets published. Please use that sparingly, as we don't want users to find it a nuisance rather than something to enhance game immersion.

The story content usually has 5 spaces at the beginning. You will need to provide/load your own translation definitions for any story you add into the story queues.

For optimal display, please keep your story within the following limitations:

* Title:  45 characters
* Story:  75 words or less (ideally more like 45)

## Queues

There are 3 story types - "Top" (front page) Stories, Engineering Stories, and Social Stories.

Each story type has 2 main queues: "Potential" and "Free" (Free is "filler" type stories).

When the MartianTribune is published, stories are first randomly selected from the Potential queue. If the Potential queue is empty, a story will be selected randomly from the Free queue. There is a third queue for each story type ("Urgent") that has higher priority than the Potential list, but this third queue should only ever be used for time-critical stories (e.g. Martian Tribune currently only uses it for death/selection of a leader, and first Founder death or first Martianborn death). Preferably there would never be more than one Urgent story in the queue for a story type (otherwise it loses the ability to force a story to be published next).

## Story Functions

The story functions available are defined in Code/Initialization.lua.

### Add&lt;StoryType&gt;&lt;StoryQueue&gt;Story

There are a series of functions available for adding stories to the selection queues:

* `MartianTribuneMod.Functions.AddTopPotentialStory(story)`
* `MartianTribuneMod.Functions.AddTopFreeStory(story)`
* `MartianTribuneMod.Functions.AddEngPotentialStory(story)`
* `MartianTribuneMod.Functions.AddEngFreeStory(story)`
* `MartianTribuneMod.Functions.AddSocialPotentialStory(story)`
* `MartianTribuneMod.Functions.AddSocialFreeStory(story)`

### Remove&lt;StoryType&gt;&lt;StoryQueue&gt;Story

There are a series of functions available for removing a story from the selection queues:

* `MartianTribuneMod.Functions.RemoveTopPotentialStory(story.key)`
* `MartianTribuneMod.Functions.RemoveTopFreeStory(story.key)`
* `MartianTribuneMod.Functions.RemoveEngPotentialStory(story.key)`
* `MartianTribuneMod.Functions.RemoveEngFreeStory(story.key)`
* `MartianTribuneMod.Functions.RemoveSocialPotentialStory(story.key)`
* `MartianTribuneMod.Functions.RemoveSocialFreeStory(story.key)`

### Utility functions

* `MartianTribuneMod.Functions.FindStoryInListByKey(list, story.key)` - find the story inside the given list by its story key.
* `MartianTribuneMod.Functions.IsValidColonist(data)` - returns true if the data represents a colonist AND the colonist is not dead.
* `MartianTribuneMod.Functions.GetColonistWithoutTrait(trait_id, colonistList)` - returns a random colonist from the provided list (or UICity.labels.Colonist if no colonistList is provided) who does not have the specified trait_id.
* `MartianTribuneMod.Functions.GetColonistWithTrait(trait_id, colonistList)` - returns a random colonist from the provided list (or from UICity.labels.Colonist if no colonistList is provided) who does have the specified trait_id.
* `MartianTribuneMod.Functions.GetColonistMatchingTraits(includeTraitList, excludeTraitList, colonistList)` - returns a random colonist from the provided list (or from UICity.labels.Colonist if no colonistList is provided) who has all of the traits in the provided the includeTraitList and none of the traits provided in the excludeTraitList. Can be used for instance to retrieve "a colonist who is both an engineer and a whiner and is not martianborn".
* `MartianTribuneMod.Functions.GetRandomDroneName()` - returns the name field from a random drone, or "Drone #1" (as a translated string) if no drones exist.
* `MartianTribuneMod.Functions.GetPopulatedDomes(domeList)` - returns the list of Domes that have Colonists from the domeList, or from UICity.labels.Dome if no domeList is provided.
* `MartianTribuneMod.Functions.GetPopulatedDomesWithoutAir()` - returns the list of Domes that have Colonists and have a current Air shortage.
* `MartianTribuneMod.Functions.GetPopulatedDomesWithoutPower()` - returns the list of Domes that have Colonists and have a current Power shortage.
* `MartianTribuneMod.Functions.GetPopulatedDomesWithoutWater()` - returns the list of Domes that have Colonists and have a current Water shortage.
* `MartianTribuneMod.Functions.GetWorkers(building)` - returns a flattened list of workers for a specific building (so that you can then do random selection or iterate through them easily).

## Story Data

There are a few story globals that may be of use when creating stories to add to the story queues:

* `MartianTribune.Sponsor` - translated display_name for the current Sponsor.
* `MartianTribune.LeaderTitle` - translated title for the Colony Leader, e.g. "Oracle" for the Church of the New Ark sponsor.
* `MartianTribune.LeaderName` - Name of the colonist who is the current colony leader.
* `MartianTribune.LeaderColonist` - Colonist who is the current colony leader.
* `MartianTribune.Published` - a list in the form `{[story.key] = true}` for all Published stories. This can be used to test whether a prior story has actually been published or not, e.g.
    ```lua
    local Published = MartianTribune.Published
    if Published[StoryKey] then
        -- Do something that should only be done after a prior story was published.
    end
    ```
* `MartianTribune.Sent` - a list of the keys for all stories that have been added to the queues at any time, in the same format as the MartianTribune.Published list. Stories with keys in the Sent list may not have been published, in which case they're either in the queue to be published, or they were subsequently removed from the queue.
* `MartianTribune.Removed` - a list of the keys for all stories that have been removed from the queues at any time, in the same format as the MartianTribune.Published list.
* `MartianTribune.TopArchive` - the list of published "Top" stories. You may need this to retrieve the publishedDay from a story, for example:
    ```lua
    local TopArchive = MartianTribune.TopArchive
    local story = MartianTribuneMod.Functions.FindStoryInListByKey(TopArchive, "AUniqueKeyString")
    if story ~= nil and UICity.day >= (story.publishedDay + 5) then
        -- Trigger something 5 days after the prior story was published.
    end
    ```
* `MartianTribune.EngArchive` - the list of published "Engineering" stories.
* `MartianTribune.SocialArchive` - the list of published "Social" stories.
* `MartianTribune.ColonistsHaveArrived` - set to true when colonists first arrive on Mars.

## Custom Messages

* `MartianTribuneCheckStories` - Martian Tribune fires a daily message for checking whether stories should be added to the queues. If you have a story that should trigger then, you can listen to the message:
    ```lua
    function OnMsg.MartianTribuneCheckStories()
        CheckMyStory()
    end
    ```
* `MartianTribuneLeaderDied` - Message fired when the Colony Leader dies.
* `MartianTribuneInitializeStories` - Message fired on first load of the Martian Tribune mod in a game. This is primarily used to be able to populate the initial 'free' story lists.
* `MartianTribuneBuildingMalfunction(building)` - Fired when a building has been set in the malfunctioned state when it hadn't been already due for maintenance. Can be used to find things like malfunctions caused by idiot workers, etc.
* `MartianTribuneUnmaintainedBuildingBroken(building)` - Fired when a building has been set in the malfunctioned state when maintenance that was required was not done.

=======
