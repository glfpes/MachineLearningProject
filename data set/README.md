# Machine Learning in DOTA2 -- Hero Composition Counts

plz contact yumaoshu at gmail.com

version-2014-4-2-night

## Background

*Each match of Dota 2 is independent and involves two teams, the Radiant and the Dire, both containing five players and each occupying a stronghold at either end of the map. Located in each stronghold is a building called the "Ancient"; to win, a team must destroy the enemy's Ancient. Each player controls a "Hero" character and focuses on leveling up, collecting gold, acquiring items and fighting against the other team to achieve victory.* -- wikipedia

*There are nine game modes and around 100 "Heroes" in Dota 2. Heroes are strategically powerful player-controlled units with unique special abilities; though many heroes fill similar roles as others, each confers different benefits and limitations to a team. These Heroes start off very weak early in the game, but level up their abilities and statistics as they accumulate experience, up to a maximum level of twenty-five. The Heroes' methods of combat are heavily influenced by their primary property, which can be Strength, Agility, or Intelligence. Most game modes provide teams with some preparation time before the game begins so that they can balance their hero selections, as the composition of the team can significantly affect their performance throughout the match. Because Dota 2 is highly team-oriented, the players must coordinate and plan with each other in order to achieve victory.* -- wikipedia

##  Motivation

Since heroes are unique, there might be some hidden soft counter or beneficial relationships between heroes. i.e. Phantom Lancer and Keeper of the Light is a good pair while Bounty Hunter is a good choice for hunting Riki.

However, human intuition is weak telling whether a whole team has the advantage against another.

DOTA2 opened its matches history to public. Can you excavate something useful from them?

## Goal

Given a subset of recent match history. You are to learn how hero selection is affecting the match with the help of your computer.

## Details

In each match, __10 heroes picked__ is the __input__ of this question. While __The match result__ is the __output__.

Except the hero composition and the match result, some extra info is also given to help. You can treat the extras as adjustment of the bare result. i.e.: Radiant got 100 kills while Dire 10 kills and won the match. You can treat the match as a wonder and tell your model the Dire suffered a lot but won, this can' t happen a second time. But they are __not available while testing__. Find some way to use them.

There are many factors that may affect the result, such as the hero familiarity of its controller, the skill of this match, the mistake or accident during the match. However, the naive baseline model got 61%(mid-size) of accuracy. Which proves that this problem is valuable.

## Problem Folder Structure

- tool programs
    - sample.py - provide some naive extracting / training / predicting method
    - tools.py - for dataset evaluating (and splitting but not for you)
    - guide10K.sh / guide100K.sh - shows the working flow of baseline program, you can just run them to see what will happen
    - guide1M_run_this_unless_you_have_more_than_32GB_memory_plz_write_your_own_extractor.sh - naive extractor will use up to 32GB memory. After that, json module will raise an Exception that it can' t handle such data. So this is not actually a guide but a joke. You need to write your own json parser and to deal with that giant under 1M/ folder. (Hint: just read, extract, and then forget instead of read the who json into memory)

- data
    - 10K/dota2_10K.txt - tiny data for training
    - 100K/dota2_100K.txt - mid-size data for training
    - 1M/dota2_1M.txt - huge-size data for training
    - test/dota2_100K_test_input.txt - data for testing
    - test/dota2_100K_test_label.txt - label of testing data
    
- readme
    - README.md
    - README.html

## Baseline

The baseline only extracted 10 heroes picked and the match result for training. However it can be regarded a shortway for you to quickly get familiar with data.

NumPy is used in baseline program to do linear regression and got 59%(tiny)/61%(mid-size) of accuracy.

## Data

There are three data set available, with the size of 10K matches(packed), 100K matches(packed) and 1M matches(packed in current version). Due to that the smaller data set is a subset of the larger one.

Please __do not__ use the smaller data set to be the test set while training the model with the larger one. Use CV instead to evaluate. A test set of 100K matches will be kept privately for final test use.

All matches were played by 10 human players in All Pick mode. Abandoned games are filtered out.

Data file is formed as a json list, aka many [] wrapped JSON Objects.
Each Object contains the following keys:

- match_id - the numeric match ID
- radiant_win - true if radiant won, false otherwise
- duration - the total time in seconds the match ran for
- tower_status_dire - an 11-bit unsinged int:

        ┌─┬─┬─┬─┬─────────────────────── Not used.
        │ │ │ │ │ ┌───────────────────── Ancient Top
        │ │ │ │ │ │ ┌─────────────────── Ancient Bottom
        │ │ │ │ │ │ │ ┌───────────────── Bottom Tier 3
        │ │ │ │ │ │ │ │ ┌─────────────── Bottom Tier 2
        │ │ │ │ │ │ │ │ │ ┌───────────── Bottom Tier 1
        │ │ │ │ │ │ │ │ │ │ ┌─────────── Middle Tier 3
        │ │ │ │ │ │ │ │ │ │ │ ┌───────── Middle Tier 2
        │ │ │ │ │ │ │ │ │ │ │ │ ┌─────── Middle Tier 1
        │ │ │ │ │ │ │ │ │ │ │ │ │ ┌───── Top Tier 3
        │ │ │ │ │ │ │ │ │ │ │ │ │ │ ┌─── Top Tier 2
        │ │ │ │ │ │ │ │ │ │ │ │ │ │ │ ┌─ Top Tier 1
        │ │ │ │ │ │ │ │ │ │ │ │ │ │ │ │
        0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
        
- tower_status_radiant - an 11-bit unsinged int
- barracks_status_dire - a 6-bit unsinged int:

        ┌─┬───────────── Not used.
        │ │ ┌─────────── Bottom Ranged
        │ │ │ ┌───────── Bottom Melee
        │ │ │ │ ┌─────── Middle Ranged
        │ │ │ │ │ ┌───── Middle Melee
        │ │ │ │ │ │ ┌─── Top Ranged
        │ │ │ │ │ │ │ ┌─ Top Melee
        │ │ │ │ │ │ │ │
        0 0 0 0 0 0 0 0
        
- barracks_status_radiant - a 6-bit unsinged int
- players - a JSON list including the following keys:
    - player_slot - an 8-bit unsigned int: if the left-most bit is set, the player was on dire. the two right-most bits represent the player slot (0-4)

            ┌─────────────── Team (false if Radiant, true if Dire).
            │ ┌─┬─┬─┬─────── Not used.
            │ │ │ │ │ ┌─┬─┬─ The position of a player within their team (0-4).
            │ │ │ │ │ │ │ │
            0 0 0 0 0 0 0 0
    
    - hero_id - the numeric ID of the hero that the player used
    - kills - the number of kills the player got
    - deaths - the number of times the player died
    - gold_per_min - the player's total gold/min
    - xp_per_min - the player's total xp/min
    - level - the player's final level
    - last_hits - the number of times a player last-hit a creep
    - denies - the number of times a player denied a creep
    - hero_damage - the amount of damage the player dealt to heroes
    - tower_damage - the amount of damage the player dealt to towers
