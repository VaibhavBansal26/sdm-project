import random
import string
import re
# Helper functions to generate review components

def random_adjective():
    adjectives = ["gorgeous", "stunning", "delicate", "elegant", "solid", "durable", "lightweight", "disappointing", "charming", "versatile", "trendy", "flimsy", "sparkly", "classic", "modern", "sleek", "chunky", "clunky", "sophisticated", "casual"]
    return random.choice(adjectives)

def random_verb():
    verbs = ["impressed", "disappointed", "satisfied", "in love", "happy", "thrilled", "regretting", "surprised", "pleased", "excited"]
    return random.choice(verbs)

def random_timeframe():
    timeframes = ["the first day", "a couple of weeks", "months", "the moment I saw it", "the first time I wore it out", "after several uses", "long-term"]
    return random.choice(timeframes)

def random_phrase():
    phrases = ["for the price", "given the hype", "considering the reviews", "for a piece like this", "for such a reputed brand", "compared to other items I’ve purchased"]
    return random.choice(phrases)



def random_experience():
    exp=['looks great', 'holds up well', 'feels comfortable', 'gets compliments', 'seems off', 'disappoints']	
    return random.choice(exp)
	  	
def random_end_phrase():
    end_phrases = ["Can't wait to show it off!", "Such a bummer.", "5 stars from me!", "I wouldn't recommend it.", "Definitely a must-buy!", "I wouldn’t buy this again."]
    return random.choice(end_phrases)


def create_varied_length_review(product):
    # Choose whether to include certain parts of the review for variety
    review_parts = [
        f"This {product} is {random_adjective()}." if random.random() < 0.75 else "",
        f"I'm {random_verb()} with it, especially {random_phrase()}." if random.random() < 0.50 else "",
        f"It's been {random_timeframe()} and it still {random_experience()}." if random.random() < 0.5 else "",
        random_end_phrase() if random.random() < 0.65 else ""
    ]
    
    # Combine the parts into a single review, skipping any empty strings
    review = ' '.join(filter(None, review_parts))
    return review

# Generate 20 varied-length reviews
product_description="SILVER LARIAT 40CM"
varied_length_reviews = [create_varied_length_review(product_description) for _ in range(20)]
for x in varied_length_reviews:
     print(x)
	
	
