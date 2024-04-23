import random
import string
import re
import pandas as pd
# import random
# import nltk
# from nltk.corpus import opinion_lexicon
# from nltk.corpus import stopwords
# from nltk.sentiment import SentimentIntensityAnalyzer

# Ensure necessary NLTK resources are available
# nltk.download('opinion_lexicon')
# nltk.download('stopwords')
# nltk.download('vader_lexicon')
# nltk.download('wordnet')

# NLTK Sentiment Analyzer
# sia = SentimentIntensityAnalyzer()


# # Positive and negative words from NLTK's opinion lexicon
# positive_words = list(opinion_lexicon.positive())
# negative_words = list(opinion_lexicon.negative())

# # English stopwords for neutral words
# english_stopwords = stopwords.words('english')


# Function to safely sample adjectives, considering the sample size
# def safe_sample(word_list, sample_size):
#     return random.sample(word_list, min(sample_size, len(word_list)))

def random_start(sentiment):
    starters = {
        'positive': ["I absolutely love", "I'm thrilled with", "What a fantastic", "I'm pleased with",
                     "I'm so excited about", "Couldn’t be happier with", "So glad I chose"],
        'negative': ["I'm disappointed with", "What a terrible", "I'm unsatisfied with", "I'm frustrated with",
                     "I regret buying", "Wouldn’t recommend", "Completely let down by"],
        'neutral': ["It's okay", "This is a standard", "What an average", "It's mediocre", "This is a typical"]
    }
    return random.choice(starters[sentiment])


def random_adjective(sentiment):
    adjectives = {
        'positive': ["gorgeous", "stunning", "delicate", "elegant", "solid", "durable", "lightweight", "charming", "versatile", "trendy", "sparkly", "classic", "modern", "sleek"],
        'negative': ["disappointing", "flimsy", "chunky", "clunky"],
        'neutral': ["casual", "standard", "typical", "common"]
    }
    return random.choice(adjectives[sentiment])    

def random_verb(sentiment):
    verbs = {
        'positive': ["impressed", "satisfied", "in love", "happy", "thrilled", "surprised", "pleased", "excited"],
        'negative': ["disappointed", "regretting"],
        'neutral': ["considering", "contemplating"]  # Neutral verbs are a bit trickier and might depend on context
    }
    return random.choice(verbs[sentiment])

def random_timeframe():
    timeframes = ["the first day", "a couple of weeks", "months", "the moment I saw it", "the first time I wore it out", "after several uses", "long-term"]
    return random.choice(timeframes)

def random_phrase():
    phrases = ["for the price", "given the hype", "considering the reviews", "for a piece like this", "for such a reputed brand", "compared to other items I’ve purchased"]
    return random.choice(phrases)




def random_experience(sentiment):
    experiences = {
        'positive': ["looks great", "holds up well", "feels comfortable", "gets compliments"],
        'negative': ["seems off", "disappoints"],
        'neutral': ["is functional", "serves its purpose"]  # Added neutral experiences
    }
    return random.choice(experiences[sentiment])

def random_end_phrase(sentiment):
    end_phrases = {
        'positive': ["Can't wait to show it off!", "5 stars from me!", "Definitely a must-buy!"],
        'negative': ["Such a bummer.", "I wouldn't recommend it.", "I wouldn’t buy this again."],
        'neutral': ["It's pretty much what I expected.", "Not bad, not great."]  # Added neutral end phrases
    }
    return random.choice(end_phrases[sentiment])



def random_end(sentiment):
    end = {
    'positive': ["I can't wait to use it again!", "I am so happy about this purchase!", "It's everything I hoped for and more!",
                 "This is one of my best purchases!", "You will not be disappointed!", "It makes life so much easier!",
                 "I'm telling all my friends about it!", "I can't imagine my life without it!", "It's a joy to use!",
                 "I would buy it again in a heartbeat!", "It's a standout product!", "I'm beyond satisfied!", 
                 "Absolutely worth every penny!", "It's just perfect!", "I'm totally in love with it!", 
                 "It has exceeded all my expectations!", "I highly recommend it to anyone!", "A true lifesaver!", 
                 "It's a total game-changer!", "I'm impressed every time I use it!", "It delivers on all fronts!", 
                 "You'll be glad you chose it!", "Can't get enough of it!", "It’s the best I’ve ever used!", 
                 "You'll be amazed!", "It's simply incredible!", "Top-notch in every way!", "You won't regret this purchase!",
                 "I'm blown away by its performance!", "It's flawless in every aspect!"],
    'negative': ["I won't be buying this again.", "I regret this decision.", "It's a total waste of money.", 
                 "I'm very unhappy with this product.", "You should definitely pass on this.", "Not worth your time or money.",
                 "I wish I had gone with another product.", "It was a huge mistake.", "It has been a disappointment.", 
                 "I'm not satisfied at all.", "It's frustrating to use.", "I would strongly advise against buying this.", 
                 "It's not what was advertised.", "I've had a bad experience.", "It's seriously lacking in quality.",
                 "Don't waste your money.", "There are better options available.", "I'm not impressed.", 
                 "It's poorly made.", "It's one of the worst purchases I've made.", "A complete letdown.", 
                 "Not up to the standard.", "I've had nothing but problems.", "It didn't meet my expectations.", 
                 "I'm very dissatisfied.", "It's a flop.", "It didn't work as expected.", "I'm left completely unimpressed.", 
                 "Avoid at all costs.", "It's definitely not worth it."],
    'neutral': ["It's not too bad.", "It does what it's supposed to do.", "Nothing to get excited about.", 
                "It's fairly average.", "It's neither good nor bad.", "It's acceptable for the price.", 
                "Not the best, but not the worst.", "It's pretty much what you would expect.", "It serves its purpose.", 
                "It's an okay product.", "It could be better, it could be worse.", "It's mediocre.", 
                "It meets the basic requirements.", "It's nothing special.", "It's a standard option.", 
                "It's adequate for everyday use.", "Don't expect too much.", "It's fine for what it is.", 
                "It's passably decent.", "It's about average.", "It gets the job done.", "It's unremarkable but functional.", 
                "It's not outstanding.", "It's competent enough.", "It's modestly satisfactory.", 
                "It will do for now.", "It's not exceptional.", "It's neither impressive nor disappointing.", 
                "It's middle of the road.", "It's just ordinary."]
    }
    return random.choice(end[sentiment])

def create_varied_length_review(product,sentiment):
    # Choose whether to include certain parts of the review for variety
   
    review_parts = [
        f"{random_start(sentiment)} {product}." if random.random() < 0.75 else "",
        f"This {product} is {random_adjective(sentiment)}." if random.random() < 0.75 else "",
        f"I'm {random_verb(sentiment)} with it, especially {random_phrase()}." if random.random() < 0.50 else "",
        f"It's been {random_timeframe()} and it still {random_experience(sentiment)}." if random.random() < 0.5 else "",
        f"{random_end_phrase(sentiment)}" if random.random() < 0.75 else ""
    ]
    # Combine the parts into a single review, skipping any empty strings
    review = ' '.join(filter(None, review_parts))
    return review

# Generate 20 varied-length reviews
product_description="SILVER LARIAT 40CM"
varied_length_reviews = [create_varied_length_review(product_description,random.choice(["positive","negative","neutral"])) for _ in range(20)]
for x in varied_length_reviews:
     print(x)
	
	
