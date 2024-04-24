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
        'positive': [
            "I absolutely love", "I'm thrilled with", "What a fantastic", "I'm pleased with",
            "I'm so excited about", "Couldn’t be happier with", "So glad I chose", "I highly recommend",
            "What a delightful", "I'm overjoyed with", "It's a total game-changer", "An excellent",
            "Simply amazing", "Truly outstanding", "Exceeds my expectations", "I'm enamored with",
            "It's perfection", "A stellar", "Top-notch", "A winner in my book"
        ],
        'negative': [
            "I'm disappointed with", "What a terrible", "I'm unsatisfied with", "I'm frustrated with",
            "I regret buying", "Wouldn’t recommend", "Completely let down by", "I'm dismayed by",
            "It's an unfortunate", "I'm underwhelmed by", "Not what I expected from", "A poor",
            "Terribly dissatisfied with", "Such a disappointment", "Leaves much to be desired",
            "A big thumbs down", "Sadly unimpressive", "Missed the mark", "Falls short of expectations",
            "A letdown"
        ],
        'neutral': [
            "It's okay", "This is a standard", "What an average", "It's mediocre",
            "This is a typical", "Nothing special about this", "An ordinary", "It's passable",
            "A run-of-the-mill", "This is fairly routine", "It's neither good nor bad", "A middling",
            "Middle of the road", "Not bad but not great", "Decidedly average", "Ordinarily acceptable",
            "It's fair", "Mediocre at best", "Barely meets the standards", "Neither here nor there"
        ]
    }
    return random.choice(starters[sentiment])



def random_adjective(sentiment):
    adjectives = {
        'positive': [
            "gorgeous", "stunning", "delicate", "elegant", "solid", "durable",
            "lightweight", "charming", "versatile", "trendy", "sparkly", "classic",
            "modern", "sleek", "exquisite", "premium", "top-quality", "impeccable",
            "exceptional", "innovative", "remarkable", "peerless", "superb", "magnificent"
        ],
        'negative': [
            "disappointing", "flimsy", "chunky", "clunky", "inferior", "subpar",
            "mediocre", "unreliable", "lackluster", "dismal", "second-rate",
            "unsatisfactory", "deficient", "faulty", "shoddy", "poorly made",
            "substandard", "inadequate", "unsound", "flawed"
        ],
        'neutral': [
            "casual", "standard", "typical", "common", "basic", "average", "plain",
            "simple", "unremarkable", "ordinary", "run-of-the-mill", "standard-issue",
            "garden-variety", "everyday", "no-frills", "undistinguished", "normal",
            "regular", "generic", "unexceptional", "workaday"
        ]
    }
    return random.choice(adjectives[sentiment])

def random_verb(sentiment):
    verbs = {
        'positive': [
            "impressed", "satisfied", "in love with", "happy about", "thrilled by", "surprised by", 
            "pleased with", "excited about", "enchanted by", "fascinated with", "delighted by", 
            "enamored with", "overjoyed with", "ecstatic about", "amazed by", "gratified by", 
            "rejoicing over", "enthralled by", "raving about", "upbeat about"
        ],
        'negative': [
            "disappointed with", "regretting", "dissatisfied with", "unhappy about", "displeased with", 
            "frustrated by", "upset with", "disgruntled about", "angered by", "annoyed with", 
            "disenchanted with", "distressed about", "discontent with", "let down by", 
            "dismayed by", "disheartened by", "resentful of", "disgusted with", "irked by", "repelled by"
        ],
        'neutral': [
            "considering", "contemplating", "evaluating", "examining", "observing", "noting", 
            "acknowledging", "recognizing", "seeing", "witnessing", "perceiving", "discerning", 
            "aware of", "regarding", "viewing", "watching", "inspecting", "studying", "assessing", "surveying"
        ]
    }
    return random.choice(verbs[sentiment])


def random_timeframe():
    timeframes = [
        "the first day", "a couple of weeks", "months", "the moment I saw it", 
        "the first time I wore it out", "after several uses", "long-term", 
        "right out of the box", "within the first few hours", "over the weekend", 
        "during my first experience with it", "after repeated use", "in the initial phase", 
        "within days", "from day one", "over the course of use", "right after setup", 
        "as soon as I started using it", "throughout my time with it", "from the get-go", 
        "within the first month", "after the honeymoon period", "over several months", 
        "since the beginning", "in the short-term", "after the first charge", "straight away",
        "after the first use", "from the onset", "in the first week"
    ]
    return random.choice(timeframes)

def random_phrase():
    phrases = [
        "for the price", "given the hype", "considering the reviews", "for a piece like this", 
        "for such a reputed brand", "compared to other items I’ve purchased", "in this category",
        "with these features", "in its class", "on the market", "for the quality provided", 
        "with such functionality", "from what I've experienced", "based on my experience", 
        "for the craftsmanship", "for the convenience", "in terms of usability", "when it comes to durability",
        "in this design", "as far as performance goes", "looking at the specs", "when you factor in the warranty",
        "considering the material", "judging by the build", "taking into account the technology", 
        "when it comes to the feature set", "for the level of innovation", "with this level of support", 
        "from an aesthetic standpoint", "when evaluating the eco-friendliness", "in the realm of efficiency",
        "with respect to user-friendliness", "in regard to portability", "concerning the battery life",
        "for its size"
    ]
    return random.choice(phrases)


def random_experience(sentiment):
    experiences = {
        'positive': [
            "looks great", "holds up well", "feels comfortable", "gets compliments",
            "exceeds expectations", "performs beautifully", "is a joy to use", "wins my heart",
            "makes life easier", "proves its worth", "delivers outstanding results",
            "is top of the line", "offers exceptional comfort", "attracts positive attention",
            "is a game changer", "brings satisfaction every day", "is built to last",
            "continues to impress", "remains reliable", "shines above the rest"
        ],
        'negative': [
            "seems off", "disappoints", "falls short", "fails to deliver", "lacks durability",
            "misses the mark", "underperforms", "is problematic", "suffers from issues",
            "leaves much to be desired", "is difficult to use", "comes up short", "is overpriced",
            "doesn't meet expectations", "wears out quickly", "breaks down often",
            "is uncomfortable", "has poor customer service", "loses value quickly", "is a hassle"
        ],
        'neutral': [
            "is functional", "serves its purpose", "does the job", "performs adequately",
            "meets basic standards", "is average", "functions as expected", "is passable",
            "performs as advertised", "holds its own", "is nothing special", "is unremarkable",
            "gets the job done", "is decent", "is moderately effective", "provides basic functionality",
            "meets minimal requirements", "is straightforward", "maintains a standard", "is utilitarian"
        ]
    }
    return random.choice(experiences[sentiment])


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

def create_varied_length_review(product):
    # Choose whether to include certain parts of the review for variety
    sentiment=random.choice(["positive","negative","neutral"])
    review_parts = [
        f"{random_start(sentiment)} {product}." if random.random() < 0.75 else "",
        f"This {product} is {random_adjective(sentiment)}." if random.random() < 0.75 else "",
        f"I'm {random_verb(sentiment)} with it, especially {random_phrase()}." if random.random() < 0.50 else "",
        f"It's been {random_timeframe()} and it still {random_experience(sentiment)}." if random.random() < 0.5 else "",
        f"{random_end(sentiment)}" if random.random() < 0.75 else ""
    ]
    # Combine the parts into a single review, skipping any empty strings
    review = ' '.join(filter(None, review_parts))
    return review

# Generate 20 varied-length reviews
product_description="SILVER LARIAT 40CM"
varied_length_reviews = [create_varied_length_review(product_description) for _ in range(20)]
for x in varied_length_reviews:
     print(x)
	
	
