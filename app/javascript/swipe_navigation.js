import Hammer from 'hammerjs';

document.addEventListener('turbo:load', () => {
  const comicWrapper = document.querySelector('.comicWrapper');

  if (comicWrapper) {
    const hammer = new Hammer(comicWrapper);
    hammer.get('swipe').set({ direction: Hammer.DIRECTION_HORIZONTAL });

    hammer.on('swipeleft', () => {
      const nextButton = document.querySelector('.comic-next');
      if (nextButton) {
        nextButton.click();
      }
    });

    hammer.on('swiperight', () => {
      const prevButton = document.querySelector('.comic-prev');
      if (prevButton) {
        prevButton.click();
      }
    });
  }
});
